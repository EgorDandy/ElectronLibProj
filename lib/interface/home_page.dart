import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/bookdatabase.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/settings_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/objects/menu_item.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/objects/book.dart';
import 'favorites_page.dart';
import 'package:flutter_application_1/custom_search_delegate.dart';
import 'menu_page.dart';
import 'search_page.dart';
import 'package:file_picker/file_picker.dart';

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
                delegate: CustomSearchDelegate(setState, books),
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
            searchList.clear();
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
            searchList.clear();
          }
        ),
        ItemMenu(
          icon: Icons.logout, 
          value: 'Выйти', 
          func: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AutorizePage()),
              (Route<dynamic> route) => false,
            );
            searchList.clear();
          }
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: searchList.map((book) => book.createBookWidget(setState, context)).toList(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Выбор файла PDF
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
          if (result != null) {
            String? filePath = result.files.single.path;

            // Показать диалог для ввода автора и названия книги
            showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController authorController = TextEditingController();
                TextEditingController titleController = TextEditingController();

                return AlertDialog(
                  title: const Text('Добавить книгу'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: authorController,
                        decoration: const InputDecoration(labelText: 'Автор'),
                      ),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Название'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          // Добавить код для сохранения данных книги
                          String author = authorController.text;
                          String title = titleController.text;
                          // Сохранить файл, автора и название книги
                          Book newBook = Book(author: author, title: title, path: filePath, isFavorite: false);
                          books.add(newBook);
                          BookDatabase.instance.addBook(title, author, filePath);
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Сохранить'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}