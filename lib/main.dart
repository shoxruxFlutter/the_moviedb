import 'package:flutter/material.dart';

import 'package:the_moviedb/main_screen/main_screen.dart';
import 'package:the_moviedb/movie_details/movie_details_widget.dart';
import 'package:the_moviedb/theme/app_colors.dart';

import 'auth/auth_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.mainDarkBlue,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.mainDarkBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          )),
      routes: {
        '/': (context) => const AuthLogin(),
        '/main_screen': (context) => const MainScreen(),
        '/main_screen/movie_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MovideDetailsWidget(
              movieId: arguments,
            );
          } else {
            return const MovideDetailsWidget(
              movieId: 0,
            );
          }
        },
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('Произошла ошибка навигаци'),
              ),
            );
          },
        );
      },
    );
  }
}
