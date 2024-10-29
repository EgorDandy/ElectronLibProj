import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/userdatabase.dart';
import 'interface/signing/autorize_page.dart';
import 'global_values.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDatabase.instance.deleteAllUsers();
  await initializeUsers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AutorizePage(),
    );
  }
}