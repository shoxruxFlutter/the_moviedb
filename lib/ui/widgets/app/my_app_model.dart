import 'package:flutter/material.dart';
import 'package:the_moviedb/domain/data_providers/session_data_provider.dart';
import 'package:the_moviedb/ui/navigation/main_navigation.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.auth,
      (_) => false,
    );
  }
}
