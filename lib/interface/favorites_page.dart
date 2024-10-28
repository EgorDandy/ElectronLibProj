import 'package:flutter/material.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/settings_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/menu_item.dart';
import 'package:flutter_application_1/global_values.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'search_page.dart';

class FavoritesPage extends StatefulWidget{
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MenuPage().createMenu([
        ItemMenu(
          icon: Icons.search, 
          value: 'Главная', 
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
            searchList.clear();
          }
        ),
        ItemMenu(
          icon: Icons.account_circle, 
          value: 'Профиль', 
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        ),
        ItemMenu(
          icon: Icons.book, 
          value: 'Библиотека', 
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            searchList = List.from(books);
          }
        ),
        ItemMenu(
          icon: Icons.settings, 
          value: 'Настройки', 
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          }
        ),
        ItemMenu(
          icon: Icons.logout, 
          value: 'Выйти', 
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AutorizePage()),
            );
          }
        ),
      ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: favorBooks.map((book) => book.createBookWidget(setState)).toList(),
          )
        )
      ),
    );
  }
}