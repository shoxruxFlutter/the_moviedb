import 'package:flutter/material.dart';
import 'package:the_moviedb/library/widgets/inherited/provider.dart';
import 'package:the_moviedb/ui/widgets/app/my_app_model.dart';
import 'package:the_moviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'movie_details_main_info_widget.dart';
import 'movie_details_main_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void initState() {
    super.initState();
    final movieDetailModel = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    movieDetailModel?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        centerTitle: true,
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: _BodyWidget(),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(model?.movieDetails?.title ?? 'Загрузка...');
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const [
        MovieDetailsMainInfoWidget(),
        SizedBox(height: 30),
        MovieDetailsMainScreenCastWidget(),
      ],
    );
  }
}
