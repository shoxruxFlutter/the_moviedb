import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_moviedb/domain/api_client/api_client.dart';
import 'package:the_moviedb/domain/data_providers/session_data_provider.dart';
import 'package:the_moviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  final int movieId;
  MovieDetails? _movieDetails;
  late DateFormat _dateFormat;
  String _locale = '';
  bool _isFavorite = false;
  Future<void>? Function()? onSessionExpired;

  MovieDetails? get movieDetails => _movieDetails;

  bool get isFavorite => _isFavorite;

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
    try {
      _movieDetails = await _apiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId;
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.sessionExpired:
          onSessionExpired?.call();
          break;
        default:
          break;
      }
    }
  }

  Future<void> toggleFavorite() async {
    final accountId = await _sessionDataProvider.getAccountId;
    final sessionId = await _sessionDataProvider.getSessionId;

    if (sessionId == null || accountId == null) return;
    try {
      _isFavorite = !_isFavorite;
      notifyListeners();
      await _apiClient.markAsFavorite(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: MediaType.movie,
          mediaId: movieId,
          isFavorite: _isFavorite);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.sessionExpired:
          onSessionExpired?.call();
          break;
        default:
          break;
      }
    }
  }
}
