// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth & Firestore Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          headlineMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white70),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: const AuthScreen(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/todo': (context) => const TodoScreen(),
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSignUp = false;
  bool showPassword = false;
  String? errorMessage;

  Future<void> _authenticate() async {
    setState(() {
      errorMessage = null;
    });

    try {
      if (isSignUp) {
        final existingUsers =
            await _auth.fetchSignInMethodsForEmail(emailController.text);
        if (existingUsers.isNotEmpty) {
          setState(() {
            errorMessage = 'An account already exists with this email.';
          });
        } else {
          final user = (await _auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          ))
              .user;

          if (user != null) {
            emailController.clear();
            passwordController.clear();

            setState(() {
              isSignUp = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Account created! Please sign in.'),
            ));
          }
        }
      } else {
        try {
          final user = (await _auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          ))
              .user;

          if (user != null) {
            emailController.clear();
            passwordController.clear();
            Navigator.pushReplacementNamed(context, '/todo');
          }
        } catch (e) {
          setState(() {
            errorMessage = 'Invalid email or password.';
          });
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(
          child: Text(
            isSignUp ? 'Sign Up' : 'Sign In',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              style:
                  const TextStyle(color: Colors.white), // Text color for input
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              style:
                  const TextStyle(color: Colors.white), // Text color for input
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
              obscureText: !showPassword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(isSignUp ? 'Sign Up' : 'Sign In'),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignUp = !isSignUp;
                  errorMessage = null;
                });
              },
              child: Text(isSignUp
                  ? 'Already have an account? Sign In'
                  : 'Don\'t have an account? Sign Up'),
            ),
            if (!isSignUp)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot_password');
                },
                child: const Text('Forgot Password?'),
              ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  String? errorMessage;
  String? successMessage;

  Future<void> _resetPassword() async {
    setState(() {
      errorMessage = null;
      successMessage = null;
    });

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      setState(() {
        successMessage = 'Password reset email sent. Please check your email.';
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error sending password reset email. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Center(
          child: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your email to receive a password reset link.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              style:
                  const TextStyle(color: Colors.white), // Text color for input
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Send Reset Link'),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            if (successMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  successMessage!,
                  style: const TextStyle(color: Colors.greenAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Center(
          child: Text(
            'Welcome',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/todo');
          },
          child: const Text('Go to Todo List'),
        ),
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  User? user;
  late Stream<QuerySnapshot> todoStream;
  String searchQuery = '';
  bool isSearchBarVisible = false;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _updateTodoStream();
    _searchController.addListener(_updateSearchQuery);
  }

  void _updateSearchQuery() {
    setState(() {
      searchQuery = _searchController.text.trim();
    });
    _updateTodoStream();
  }

  void _updateTodoStream() {
    if (searchQuery.isEmpty) {
      todoStream = _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('todos')
          .snapshots();
    } else {
      todoStream = _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('todos')
          .where('title', isGreaterThanOrEqualTo: searchQuery)
          .where('title', isLessThanOrEqualTo: '$searchQuery\uf8ff')
          .snapshots();
    }
  }

  Future<void> _addTodo() async {
    if (_todoController.text.trim().isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('todos')
          .add({'title': _todoController.text.trim()});
      _todoController.clear();
    }
  }

  Future<void> _updateTodo(DocumentSnapshot document) async {
    final TextEditingController updateController = TextEditingController();
    updateController.text = document['title'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: const Text(
            'Update Todo',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: updateController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (updateController.text.trim().isNotEmpty) {
                  await _firestore
                      .collection('users')
                      .doc(user!.uid)
                      .collection('todos')
                      .doc(document.id)
                      .update({'title': updateController.text.trim()});
                  Navigator.pop(context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTodo(DocumentSnapshot document) async {
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('todos')
        .doc(document.id)
        .delete();
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: isSearchBarVisible
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search Todos',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              )
            : const Text(
                'Todo List',
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          if (!isSearchBarVisible)
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  isSearchBarVisible = true;
                });
              },
            ),
          if (isSearchBarVisible)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  isSearchBarVisible = false;
                  _searchController.clear();
                  searchQuery = '';
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isSearchBarVisible)
              Column(
                children: [
                  TextField(
                    controller: _todoController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Add a Todo'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addTodo,
                    child: const Text('Add'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: todoStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'An error occurred!',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.docs.isEmpty && searchQuery.isNotEmpty) {
                    return const Center(
                      child: Text(
                        'No todos found.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> todo =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(
                          todo['title'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () => _updateTodo(document),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                              onPressed: () => _deleteTodo(document),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
