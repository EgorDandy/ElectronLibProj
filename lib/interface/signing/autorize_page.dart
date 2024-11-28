import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/bookdatabase.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/ffi/native.dart';
import 'registry_page.dart';
import 'package:flutter_application_1/interface/search_page.dart';

class AutorizePage extends StatefulWidget{
  const AutorizePage({super.key});

  @override
  State<AutorizePage> createState() => _AutorizePageState();
}

class _AutorizePageState extends State<AutorizePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 192.0),
        child: Column(
          children: [
            ...autorizeAdapter.getWidgets(16.0),
            Text(errorMes, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                //errorMes = '';
                String login = autorizeAdapter.getValue('Логин');
                String password = autorizeAdapter.getValue('Пороль');
                bool isExist = false;
                if (allUsers.isEmpty) {
                  errorMes = "Нет зарегистрированных пользователей";
                  isExist = false;
                }
                else {
                  for (final user in allUsers) {
                    String origPassword = user['password'];
                    String origLogin = user['username'];
                    if (compareStrings(origLogin.toNativeUtf8(), login.toNativeUtf8()) == false) {
                      isExist = false;
                      errorMes = 'Неверный логин';
                    } else if (compareStrings(origPassword.toNativeUtf8(), password.toNativeUtf8()) == false) {
                      isExist = false;
                      errorMes = 'Неверный пороль';
                    }
                    else {
                      isExist = true;
                      errorMes = '';
                      curUser = user;
                      bookTableName = curUser['book_table_address'];
                      books = await BookDatabase.instance.getAllBooks();
                      break;
                    }
                  }
                }
                if (isExist) {
                  autorizeAdapter.dispose();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                    (Route<dynamic> route) => false,
                  );
                }
                else {
                  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const AutorizePage()),
                        (Route<dynamic> route) => false,
                      );
                }
              },
              child: const Text('Войти'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                autorizeAdapter.dispose();
                errorMes = '';
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RegystryPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Регистрация'),
            ),
          ]
        )
      ),
    );
  }
}