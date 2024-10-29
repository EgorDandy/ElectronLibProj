import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/userdatabase.dart';
import 'authority.dart';
import 'objects/book.dart';


final homeOptions = [
  AuthOption('Регистрация'),
  AuthOption('Авторизация'),
];
final homeAdapter = AuthOptionAdapter(homeOptions);

final regOptions = [
  AuthOption('Придумайте логин'),
  AuthOption('Придумайте пороль'),
  AuthOption('Повторите пороль')
];

final regAdapter = AuthOptionAdapter(regOptions);

final autrizeOptions = [
  AuthOption('Логин'),
  AuthOption('Пороль'),
];
final autorizeAdapter = AuthOptionAdapter(autrizeOptions);


final userdb = UserDatabase.instance.database;
List<Map<String, dynamic>> allUsers = [];
Future<void> initializeUsers() async {
  allUsers = await UserDatabase.instance.getAllUsers();
}
Map<String, dynamic> curUser = {};


String errorMes = '';


String bookTableName = '';
List<Book> books = [];
List<Book> favorBooks = [];
List<Book> searchList = [];

MaterialColor mainColor = Colors.orange;