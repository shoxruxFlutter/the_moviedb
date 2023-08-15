import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_moviedb/domain/api_client/api_client.dart';
import 'package:the_moviedb/ui/navigation/main_navigation.dart';

import '../../../domain/entity/movie.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  var isLoadingProgress = false;
  String _locale = '';

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear;
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (isLoadingProgress || _currentPage >= _totalPage) return;
    isLoadingProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final movies = await _apiClient.popularMovie(nextPage, _locale);
      _movies.addAll(movies.movies);
      _currentPage = movies.page;
      _totalPage = movies.totalPages;
      isLoadingProgress = false;
      notifyListeners();
    } catch (e) {
      isLoadingProgress = false;
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  void showeMovieAtIndex(int index) {
    if (index < movies.length - 1) return;
    _loadMovies();
  }
}
