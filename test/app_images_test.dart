import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_moviedb/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.actor).existsSync(), true);
    expect(File(AppImages.headerBg).existsSync(), true);
    expect(File(AppImages.headerBg_).existsSync(), true);
    expect(File(AppImages.johnWick).existsSync(), true);
  });
}
