import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/library_viewmodel.dart';
import 'home_view.dart';
import 'search_view.dart';
import '../widgets/bottom_nav_item.dart';
import '../models/movie.dart';
import '../widgets/movie_list.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  int _selectedIndex = 2;

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LibraryView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LibraryViewModel(),
      child: Consumer<LibraryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0xFF2E2739),
                title: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                ),
                centerTitle: true,
              ),
              body: const Center(child: CircularProgressIndicator()),
              bottomNavigationBar: Container(
                width: double.infinity,
                height: 75,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E2739),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      isSelected: _selectedIndex == 0,
                      onTap: () => _onBottomNavItemTapped(0),
                    ),
                    BottomNavItem(
                      icon: Icons.search,
                      label: 'Search',
                      isSelected: _selectedIndex == 1,
                      onTap: () => _onBottomNavItemTapped(1),
                    ),
                    BottomNavItem(
                      icon: Icons.library_books,
                      label: 'Library',
                      isSelected: _selectedIndex == 2,
                      onTap: () => _onBottomNavItemTapped(2),
                    ),
                  ],
                ),
              ),
            );
          }

          final libraryMovies = viewModel.movies;

          final movieList = libraryMovies
              .map((libraryMovie) => Movie(
                    id: libraryMovie.id,
                    title: libraryMovie.title,
                    posterPath: libraryMovie.posterPath,
                    rating: libraryMovie.rating,
                    overview: '',
                  ))
              .toList();

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFF2E2739),
              title: Image.asset(
                'assets/images/logo.png',
                height: 40,
              ),
              centerTitle: true,
            ),
            body: movieList.isNotEmpty
                ? MovieList(movies: movieList)
                : const Center(
                    child: Text(
                      'No movies in your library.',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
            bottomNavigationBar: Container(
              width: double.infinity,
              height: 75,
              decoration: const BoxDecoration(
                color: Color(0xFF2E2739),
                borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(
                    icon: Icons.home,
                    label: 'Home',
                    isSelected: _selectedIndex == 0,
                    onTap: () => _onBottomNavItemTapped(0),
                  ),
                  BottomNavItem(
                    icon: Icons.search,
                    label: 'Search',
                    isSelected: _selectedIndex == 1,
                    onTap: () => _onBottomNavItemTapped(1),
                  ),
                  BottomNavItem(
                    icon: Icons.library_books,
                    label: 'Library',
                    isSelected: _selectedIndex == 2,
                    onTap: () => _onBottomNavItemTapped(2),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
