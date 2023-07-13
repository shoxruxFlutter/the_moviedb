import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(AppImages.johnWick),
        ),
      ),
    );
  }
}
