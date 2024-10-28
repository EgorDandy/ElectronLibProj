import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/user.dart';
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
      appBar: AppBar(title: const Text('Вход')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 192.0),
        child: Column(
        children: [
          ...autorizeAdapter.getWidgets(16.0),
          Text(errorMes, style: const TextStyle(color: Colors.red)),
          ElevatedButton(
          onPressed: () {
            errorMes = '';
            String login = autorizeAdapter.getValue('Логин');
            String password = autorizeAdapter.getValue('Пороль');
            for (User user in users) {
              String result = user.tryEntry(login, password);
              if (result == 'yees') {
                errorMes = '';
                autorizeAdapter.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
                break;
               } else {
                  setState(() {
                    errorMes = result;
                  });
               }
               
            }
          },
          child: const Text('Войти'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
          onPressed: () {
            errorMes = '';
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegystryPage()),
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