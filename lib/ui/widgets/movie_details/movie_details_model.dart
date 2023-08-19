import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_moviedb/domain/api_client/api_client.dart';
import 'package:the_moviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final int movieId;
  MovieDetails? _movieDetails;
  late DateFormat _dateFormat;
  String _locale = '';

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _loadDetails();
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> _loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    notifyListeners();
  }
}
