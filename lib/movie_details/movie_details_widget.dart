import 'package:flutter/material.dart';
import 'package:the_moviedb/movie_details/movie_details_main_info_widget.dart';

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
      body: ListView(
        children: const [
          MovieDetailsMainInfoWidget(),
        ],
      ),
    );
  }
}
