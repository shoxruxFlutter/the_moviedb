import 'package:flutter/material.dart';
import 'package:the_moviedb/ui/widgets/app/my_app.dart';
import 'package:the_moviedb/ui/widgets/app/my_app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  final myApp = MyApp(model: model);
  runApp(myApp);
}
