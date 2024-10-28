import 'package:flutter/material.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/settings_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/menu_item.dart';
import 'package:flutter_application_1/global_values.dart';
import 'favorites_page.dart';
import 'package:flutter_application_1/custom_search_delegate.dart';
import 'menu_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Библиотека'),
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(setState),
              );
            },
          ),
        ],
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
        )
      ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: searchList.map((book) => book.createBookWidget(setState)).toList(),
          )
        )
      ),
    );
  }
}