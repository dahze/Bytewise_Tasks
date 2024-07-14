import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  await Hive.openBox<TodoItem>('todoBox');
  runApp(const MyApp());
}

@HiveType(typeId: 0)
class TodoItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool isCompleted;

  TodoItem({required this.id, required this.title, this.isCompleted = false});
}

class TodoItemAdapter extends TypeAdapter<TodoItem> {
  @override
  final typeId = 0;

  @override
  TodoItem read(BinaryReader reader) {
    return TodoItem(
      id: reader.readString(),
      title: reader.readString(),
      isCompleted: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoItem obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeBool(obj.isCompleted);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthenticationScreen(),
    );
  }
}

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isSignIn ? 'Sign In' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isSignIn) {
                  // Simulate sign in (for demo purposes)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TodoListScreen()),
                  );
                } else {
                  // Simulate sign up (for demo purposes)
                  setState(() {
                    isSignIn = true;
                  });
                }
              },
              child: Text(isSignIn ? 'Sign In' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignIn = !isSignIn;
                });
              },
              child: Text(isSignIn
                  ? 'Don\'t have an account? Sign Up'
                  : 'Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Box<TodoItem> todoBox;
  final TextEditingController textEditingController = TextEditingController();
  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoItem>('todoBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box<TodoItem> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No to-do items yet.'));
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              TodoItem item = box.getAt(index)!;
              return ListTile(
                title: Text(item.title),
                leading: Checkbox(
                  value: item.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      item.isCompleted = value!;
                      box.putAt(index, item);
                    });
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditDialog(item, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        box.deleteAt(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To-Do Item'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(hintText: 'Enter to-do item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newItem = TodoItem(
                  id: uuid.v4(),
                  title: textEditingController.text,
                );
                todoBox.add(newItem);
                textEditingController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(TodoItem item, int index) {
    textEditingController.text = item.title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit To-Do Item'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(hintText: 'Enter to-do item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                item.title = textEditingController.text;
                todoBox.putAt(index, item);
                textEditingController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
