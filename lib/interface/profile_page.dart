import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/interface/favorites_page.dart';
import 'package:flutter_application_1/interface/home_page.dart';
import 'package:flutter_application_1/interface/search_page.dart';
import 'package:flutter_application_1/interface/settings_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/menu_item.dart';
import 'menu_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
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
          },
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
          },
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
          },
        ),
        ItemMenu(
          icon: Icons.settings,
          value: "Настройки",
          func:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        ItemMenu(
          icon: Icons.logout,
          value: 'Выйти',
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AutorizePage()),
            );
          },
        ),
      ]),
      body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 110,
                      backgroundImage: NetworkImage('user_icon.jpg'),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Логин пользователя',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                '  Количество книг:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                '  Количество избранных:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 70),
            ],
          )
        ),
    );
  }
}
