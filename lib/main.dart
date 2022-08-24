import 'package:desktop_todo_app/helpers/objectbox_interface.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

late ObjectBox objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}
