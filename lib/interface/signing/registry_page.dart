import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:flutter_application_1/user.dart';

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
          onPressed: () {
            errorMes = '';
            String login = regAdapter.getValue('Придумайте логин');
            String password = regAdapter.getValue('Придумайте пороль');
            String secPassword = regAdapter.getValue('Повторите пороль');
            if (login == '' || password == '' || secPassword == '') {
              setState(() {
                errorMes = 'Все поля должны быть заполнены';
              });
            } else {
            for (User user in users) {
              String result = user.tryEntry(login, password);
              if (result == 'yees' || result == 'Incorrect password') {
                setState(() {
                    errorMes = 'Такой пользователь уже существует';
                  });
                break;
               } else {
                  if (password != secPassword) {
                    setState(() {
                    errorMes = 'Пороли не совподают';
                  });
                  }
                  else {
                    users.add(User(login, password));
                    regAdapter.dispose();
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AutorizePage()),
                  );
                  }
               }
            }
            }
          },
          child: const Text('Зарегистрироваться'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
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