import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/userdatabase.dart';
import 'package:flutter_application_1/interface/favorites_page.dart';
import 'package:flutter_application_1/interface/home_page.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/search_page.dart';
import 'package:flutter_application_1/interface/signing/registry_page.dart';
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
    return MaterialApp(
      home: const AutorizePage(),

      routes: {
        '/autorize' : (context) => const AutorizePage(),
        '/registry' : (context) => const RegystryPage(),
        '/library' : (context) => const HomePage(),
        '/search' : (context) => const SearchPage(),
        '/favorite' : (context) => const FavoritesPage(),
        '/profile' : (context) => const ProfilePage(),
      }
    );
  }
}