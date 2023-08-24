import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_moviedb/domain/api_client/api_client.dart';
import 'package:the_moviedb/domain/data_providers/session_data_provider.dart';
import 'package:the_moviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;

  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Сервер не доступен. Проверте подключение к интернету';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Неправильный логин пароль!';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произошла ошибка, Попробуйте еще раз';
          break;
        case ApiClientExceptionType.sessionExpired:
          break;
      }
    } catch (e) {
      _errorMessage = 'Произошла ошибка, Попробуйте еще раз';
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null || accountId == null) {
      _errorMessage = 'Неизвестная ошибка, повторите попытку';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
    // ignore: use_build_context_synchronously
    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen));
  }
}
