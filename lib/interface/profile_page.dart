import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/userdatabase.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/interface/favorites_page.dart';
import 'package:flutter_application_1/interface/home_page.dart';
import 'package:flutter_application_1/interface/search_page.dart';
import 'package:flutter_application_1/interface/settings_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/objects/menu_item.dart';
import 'menu_page.dart';
import 'package:image_picker/image_picker.dart'; 
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String login = curUser['username'];
  int bookAmo = books.length;
  int favorAmo = favorBooks.length;
  File? _image; 
  final picker = ImagePicker();

  @override 
  void initState() {
    super.initState();
    _loadPhoto(); 
  }

  Future<void> _loadPhoto() async { 
    if (curUser['photo'] != null) { 
      setState(() { 
        _image = File(curUser['photo']); 
      }); 
    } 
  }

  Future getImage() async { 
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); 
    final UserDatabase db = UserDatabase.instance;
    if (pickedFile != null) { 
      setState(() { 
        _image = File(pickedFile.path); 
      });
      await db.updatePhoto(pickedFile.path);
    } else { 
      print('No image selected.'); 
    } 
  }

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
            searchList.clear();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
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
          },
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
          },
        ),
        ItemMenu(
          icon: Icons.settings,
          value: "Настройки",
          func:() {
            searchList.clear();
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
            searchList.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AutorizePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ]),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack( 
                      children: [ 
                        CircleAvatar( 
                          radius: 110, 
                          backgroundImage: _image != null 
                              ? FileImage(_image!) 
                              : AssetImage('assets/user_icon.jpg') as ImageProvider, 
                        ), 
                        Positioned( 
                          bottom: 0, 
                          right: 0, 
                          child: IconButton( 
                            icon: Icon(Icons.edit), 
                            onPressed: getImage, 
                            tooltip: 'Изменить фото', 
                            iconSize: 30, 
                            color: Colors.orange, 
                          ), 
                        ), 
                      ], 
                    ), 
                    SizedBox(height: 50), 
                    Text( 
                      login, 
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold), 
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                '  Количество книг: $bookAmo',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                '  Количество избранных: $favorAmo',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 70),
            ],
          )
        ),
    );
  }
}
