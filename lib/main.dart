import 'package:flutter/material.dart';
import 'package:the_moviedb/library/widgets/inherited/provider.dart';
import 'package:the_moviedb/ui/widgets/app/my_app.dart';
import 'package:the_moviedb/ui/widgets/app/my_app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  const myApp = MyApp();
  final widget = Provider(model: model, child: myApp);
  runApp(widget);
}
