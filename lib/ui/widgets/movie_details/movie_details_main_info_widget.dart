import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_moviedb/domain/api_client/image_downloader.dart';
import 'package:the_moviedb/ui/navigation/main_navigation.dart';
import 'package:the_moviedb/ui/widgets/movie_details/movie_details_model.dart';
import '../../../domain/entity/movie_details_credits.dart';
import '../main_screen/test.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TopPosterWidget(),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: _MovieNameWidget(),
        ),
        const _ScoreWidget(),
        const _SummaryWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _overViewWidget(),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _PeopleWidgets(),
        ),
      ],
    );
  }

  Text _overViewWidget() {
    return const Text('Overview',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ));
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget();

  @override
  Widget build(BuildContext context) {
    final overview =
        context.select((MovieDetailsModel model) => model.data.overview);
    return Text(
      overview,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    final posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    final posterPath = posterData.posterPath;
    final backdropPath = posterData.backdropPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ImageDownloader.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ImageDownloader.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: () => model.toggleFavorite(context),
                icon: Icon(posterData.favoriteIcon),
              ))
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget();

  @override
  Widget build(BuildContext context) {
    final nameData =
        context.select((MovieDetailsModel model) => model.data.nameData);
    return Center(
      child: RichText(
        maxLines: 3,
        text: TextSpan(
          children: [
            TextSpan(
                text: nameData.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            TextSpan(
                text: nameData.year,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    final scoreData =
        context.select((MovieDetailsModel model) => model.data.scoreData);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: scoreData.voteAverage / 100,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: Text(scoreData.voteAverage.toStringAsFixed(0)),
                ),
              ),
              const SizedBox(width: 10),
              const Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        if (scoreData.trailerKey != null)
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              MainNavigationRouteNames.movieTrailerWidget,
              arguments: scoreData.trailerKey,
            ),
            child: const Row(
              children: [
                Icon(Icons.play_arrow),
                Text('Play Trailer'),
              ],
            ),
          ),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget();

  @override
  Widget build(BuildContext context) {
    final summary =
        context.select((MovieDetailsModel model) => model.data.summary);
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(summary,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            )),
      ),
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets();

  @override
  Widget build(BuildContext context) {
    var crew =
        context.select((MovieDetailsModel model) => model.data.peopleData);
    if (crew.isEmpty) return const SizedBox.shrink();
    return Column(
      children: crew
          .map(
            (chunk) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _PeopleWidgetsRow(employes: chunk),
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<MovieDetailsMoviePeopleData> employes;
  const _PeopleWidgetsRow({
    Key? key,
    required this.employes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: employes
          .map(
            (employee) => _PeopleWidgetsRowItem(
              employee: employee,
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final MovieDetailsMoviePeopleData employee;
  const _PeopleWidgetsRowItem({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    const jobTilteStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: nameStyle),
          Text(employee.job, style: jobTilteStyle),
        ],
      ),
    );
  }
}
