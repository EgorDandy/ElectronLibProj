import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/userdatabase.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';

class RegystryPage extends StatefulWidget{
  const RegystryPage({super.key});

  @override
  State<RegystryPage> createState() => _RegystryPageState();
}

class _RegystryPageState extends State<RegystryPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 192.0),
        child: Column(
        children: [
          ...regAdapter.getWidgets(16.0),
          Text(errorMes, style: const TextStyle(color: Colors.red)),
          ElevatedButton(
          onPressed: () async {
            errorMes = '';
            String login = regAdapter.getValue('Придумайте логин');
            String password = regAdapter.getValue('Придумайте пороль');
            String secPassword = regAdapter.getValue('Повторите пороль');
            if (login == '' || password == '' || secPassword == '') {
              setState(() {
                errorMes = 'Все поля должны быть заполнены';
              });
            } else if (password != secPassword) {
              setState(() {
                errorMes = 'Пароли не совпадают';
              });
            } else {
              bool userExists = false;
              for (final user in allUsers) {
                if (user['username'] == login) {
                  userExists = true;
                  break;
                }
              }
              if (userExists) {
                setState(() {
                  errorMes = 'Пользователь с таким логином уже существует';
                });
              } else {
                // Добавление пользователя в базу данных
                final bookTableAddress = '${login}_books';
                await UserDatabase.instance.addUser(login, password, bookTableAddress);
                // Обновление глобального списка пользователей
                allUsers = await UserDatabase.instance.getAllUsers();
                regAdapter.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AutorizePage()),
                );
              }
            }
          },
          child: const Text('Зарегистрироваться'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            regAdapter.dispose();
            errorMes = '';
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AutorizePage()),
            );
          },
          child: const Text('Вход'),
        )
        ]
        )
      ),
    );
  }
}