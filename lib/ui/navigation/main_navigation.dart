import 'package:flutter/material.dart';
import 'package:the_moviedb/library/widgets/inherited/provider.dart';
import 'package:the_moviedb/ui/widgets/auth/auth_widget.dart';
import 'package:the_moviedb/ui/widgets/main_screen/main_screen_model.dart';

import '../widgets/auth/auth_model.dart';
import '../widgets/main_screen/main_screen.dart';
import '../widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        NotifierProvider(model: AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) =>
        NotifierProvider(model: MainScreenModel(), child: const MainScreen()),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => MovideDetailsWidget(movieId: movieId),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
