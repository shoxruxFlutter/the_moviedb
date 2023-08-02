import 'package:flutter/material.dart';
import 'movie_details_main_info_widget.dart';
import 'movie_details_main_screen_cast_widget.dart';

class MovideDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovideDetailsWidget({super.key, required this.movieId});

  @override
  State<MovideDetailsWidget> createState() => _MovideDetailsWidgetState();
}

class _MovideDetailsWidgetState extends State<MovideDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tom Clancy`s Without Remorse')),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: const [
            MovieDetailsMainInfoWidget(),
            SizedBox(height: 30),
            MovieDetailsMainScreenCastWidget(),
          ],
        ),
      ),
    );
  }
}