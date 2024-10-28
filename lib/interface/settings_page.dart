import 'package:flutter/material.dart';
import 'package:flutter_application_1/interface/home_page.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'menu_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/menu_item.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
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
          func: (){
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
          icon: Icons.star,
          value: 'Избранное',
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage()),
            );
            searchList = List.from(favorBooks);
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
        )
      ]),
      body: Center(
        child: Column(
          children: searchList.map((book) => book.createBookWidget(setState)).toList(),
        )
      ),
    );
  }
}