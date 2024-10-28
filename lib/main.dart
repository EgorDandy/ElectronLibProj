import 'package:flutter/material.dart';
import 'interface/signing/autorize_page.dart';

void main() {
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