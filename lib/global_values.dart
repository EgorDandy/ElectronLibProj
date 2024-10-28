import 'package:flutter/material.dart';
import 'authority.dart';
import 'objects/book.dart';
import 'user.dart';
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

User firstUser = User('first', '12345678');

List<User> users = [firstUser];

String errorMes = '';

List<Book> books = [
  Book(title: 'Book 1', author: 'Author 1',  isFavorite: false), 
  Book(title: 'Book 2', author: 'Author 2',  isFavorite: false),
  Book(title: 'Book 3', author: 'Author 3',  isFavorite: false),
  Book(title: 'Book 4', author: 'Author 4',  isFavorite: false)
];
List<Book> favorBooks = [];
List<Book> searchList = [];

MaterialColor mainColor = Colors.orange;