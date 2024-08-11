import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/search_viewmodel.dart';
import '../widgets/movie_list.dart';
import '../widgets/search_bar.dart' as custom;
import '../views/home_view.dart';
import '../views/library_view.dart';
import '../widgets/bottom_nav_item.dart';
import '../models/movie.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchViewModel>(context, listen: false).loadGenres();
    });
  }

  void _onSearchTextChanged() {
    final query = _searchController.text;
    Provider.of<SearchViewModel>(context, listen: false).searchMovies(query);
  }

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
      create: (_) => SearchViewModel(),
      child: Scaffold(
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
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              custom.SearchBar(controller: _searchController),
              Expanded(
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (viewModel.searchResults.isEmpty) {
                      if (_searchController.text.isEmpty) {
                        if (viewModel.genres.isEmpty) {
                          return const Center(
                              child: Text('No genres available',
                                  style: TextStyle(color: Colors.white)));
                        }
                        return ListView.builder(
                          itemCount: viewModel.genres.length,
                          itemBuilder: (context, index) {
                            final genre = viewModel.genres[index];
                            return FutureBuilder<List<Movie>>(
                              future: viewModel.fetchMoviesByGenre(genre.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                      child: Text('Error loading movies',
                                          style:
                                              TextStyle(color: Colors.white)));
                                }
                                if (snapshot.data == null ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'No movies available for this genre',
                                          style:
                                              TextStyle(color: Colors.white)));
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        genre.name,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    MovieList(movies: snapshot.data!),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      }
                      return const Center(
                          child: Text('No results found',
                              style: TextStyle(color: Colors.white)));
                    }
                    return MovieList(movies: viewModel.searchResults);
                  },
                ),
              ),
            ],
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
      ),
    );
  }
}
