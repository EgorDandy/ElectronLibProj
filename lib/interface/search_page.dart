import 'package:flutter/material.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/settings_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/objects/menu_item.dart';
import 'package:flutter_application_1/global_values.dart';
import 'favorites_page.dart';
import 'package:flutter_application_1/custom_search_delegate.dart';
import 'menu_page.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  String bodyMess = 'Ищите книги здесь...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
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
                delegate: CustomSearchDelegate(setState, books),
              );
              bodyMess = 'Результаты поиска';
            },
          ),
        ],
      ),
      drawer: MenuPage().createMenu([
        ItemMenu(
          icon: Icons.account_circle, 
          value: 'Профиль', 
          func: (){
            searchList.clear();
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
            searchList = List.from(books);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        ),
        ItemMenu(
          icon: Icons.star,
          value: 'Избранное',
          func: () {
            searchList = List.from(favorBooks);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage()),
            );
          }
        ),
        ItemMenu(
          icon: Icons.settings, 
          value: 'Настройки', 
          func: () {
            searchList.clear();
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
            searchList.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AutorizePage()),
              (Route<dynamic> route) => false,
            );
          }
        )
      ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text (
                bodyMess,
                style: const TextStyle(
                  fontSize: 16
                ),
              )
            ]
          )
        )
      ),
    );
  }
}