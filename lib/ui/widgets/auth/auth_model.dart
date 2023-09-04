import 'package:flutter/material.dart';
import 'package:the_moviedb/domain/api_client/api_client_exception.dart';
import 'package:the_moviedb/domain/services/auth_services.dart';
import 'package:the_moviedb/ui/navigation/main_navigation.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;

  bool get canStartAuth => !_isAuthProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty || password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await _authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Сервер не доступен. Проверте подключение к интернету';
        case ApiClientExceptionType.auth:
          return 'Неправильный логин пароль!';
        case ApiClientExceptionType.other:
          return 'Произошла ошибка, Попробуйте еще раз';
        case ApiClientExceptionType.sessionExpired:
      }
    } catch (e) {
      'Неизвестная ошибка, повторите попытку';
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _updateState('Заполните логин и пароль', false);
      return;
    }
    _updateState(null, true);

    _errorMessage = await _login(login, password);

    if (_errorMessage == null) {
      // ignore: use_build_context_synchronously
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
