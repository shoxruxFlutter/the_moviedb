import 'package:flutter/material.dart';
import 'package:the_moviedb/domain/data_providers/session_data_provider.dart';
import 'package:the_moviedb/library/widgets/inherited/provider.dart';

import 'package:the_moviedb/ui/widgets/movie_list/movie_list_model.dart';
import '../movie_list/movie_list.dart';
import 'test.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();

  void _onSelectedTab(int index) {
    if (_selectedTab == index) return;
    _selectedTab = index;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMBD'),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const Test(),
          NotifierProvider(
            create: () => movieListModel,
            isManagingModel: false,
            child: const MovieList(),
          ),
          const Text('TV Series page'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Фильмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Сериалы',
          )
        ],
        onTap: _onSelectedTab,
      ),
    );
  }
}
