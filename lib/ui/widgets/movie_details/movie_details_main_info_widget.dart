import 'package:flutter/material.dart';

import 'package:the_moviedb/resources/resources.dart';

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
          child: _OverviewWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        const SizedBox(height: 30),
        const _PeopleWidgets(),
      ],
    );
  }

  Text _DescriptionWidget() {
    return const Text(
        'An elite Navy SEAL uncovers an international conspiracy while seeking justice for the murder of his pregnant wife.',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ));
  }

  Text _OverviewWidget() {
    return const Text('Overview',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ));
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Image(image: AssetImage(AppImages.headerBg)),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(image: AssetImage(AppImages.headerBg_)),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget();

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: const TextSpan(
        children: [
          TextSpan(
              text: 'Tom Clancy`s Without Remorse ',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          TextSpan(
              text: '(2021)',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: 0.72,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: Text('72'),
                ),
              ),
              SizedBox(width: 10),
              Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        TextButton(
            onPressed: () {},
            child: const Row(
              children: [Icon(Icons.play_arrow), Text('Play Trailer')],
            )),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text('R 29/04/2021 (US) 1h 49m Action, Adventure, Thriller, War',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
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
    const nameStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
    const jobTitleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
    return const Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stefano Sollima', style: nameStyle),
                Text('Director', style: jobTitleStyle),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stefano Sollima', style: nameStyle),
                Text('Director', style: jobTitleStyle),
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stefano Sollima', style: nameStyle),
                Text('Director', style: jobTitleStyle),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stefano Sollima', style: nameStyle),
                Text('Director', style: jobTitleStyle),
              ],
            )
          ],
        )
      ],
    );
  }
}
