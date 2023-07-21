import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_moviedb/resources/resources.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Series Cast',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: 20,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: [
                          const Image(image: AssetImage(AppImages.actor)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Steven Yeun'),
                                SizedBox(height: 7),
                                Text('Mark Grayson / Invincible (voice)'),
                                SizedBox(height: 7),
                                Text('8 Episodes'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextButton(
            onPressed: () {},
            child: Text('Full Cast & Crew'),
          ),
        )
      ]),
    );
  }
}
