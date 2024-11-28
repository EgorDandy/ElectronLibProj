import 'package:flutter/material.dart';
import 'package:flutter_application_1/interface/home_page.dart';
import 'package:flutter_application_1/interface/profile_page.dart';
import 'package:flutter_application_1/interface/signing/autorize_page.dart';
import 'package:sqflite/sqflite.dart';
import 'menu_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/objects/menu_item.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  Future<String> getPassword() async { 
    return curUser['password'];
  }

  Future<void> updatePassword(String newPassword) async { 
    final Database db = await userdb; 
    await db.update( 
      'users', 
      {'password': newPassword}, 
      where: 'username = ?', 
      whereArgs: [curUser['username']], 
      // замените на реальный идентификатор пользователя 
    );
    ScaffoldMessenger.of(context).showSnackBar( 
      SnackBar( 
        content: Text('Для применения изменений перезапустите приложение'), 
      ), 
    );
  } 

  Future<void> updateUsername(String newUsername) async { 
    final Database db = await userdb; 
    await db.update( 
      'users', 
      {'username': newUsername}, 
      where: 'username = ?', 
      whereArgs: [curUser['username']], 
      // замените на реальный идентификатор пользователя 
    );
    ScaffoldMessenger.of(context).showSnackBar( 
      SnackBar( 
        content: Text('Для применения изменений перезапустите приложение'), 
      ), 
    );
  } 
  
  Future<void> deleteUser(BuildContext context) async { 
    final Database db = await userdb;
    await db.delete( 
      'users', 
      where: 'username = ?', 
      whereArgs: [curUser['username']], 
      // замените на реальный идентификатор пользователя 
    );
    Navigator.of(context).pushReplacement( 
      MaterialPageRoute(builder: (context) => AutorizePage()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
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
          }
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: <Widget>[
            SizedBox(height: 250), 
            ElevatedButton( 
              onPressed: () { 
                // Пример обновления пароля 
                _showChangePasswordDialog(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Изменить пароль', 
                style: TextStyle(
                  color: Colors.black,
                )
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton( 
              onPressed: () { 
                // Пример обновления логина 
                _showChangeUsernameDialog(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              child: Text(
                'Изменить логин',
                style: TextStyle(
                  color: Colors.black,
                )
              ), 
            ),
            SizedBox(height: 25),
            ElevatedButton( 
              onPressed: () { 
                // Пример удаления пользователя 
                _showDeleteUserDialog(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              child: Text(
                'Удалить пользователя',
                style: TextStyle(
                  color: Colors.black,
                )
              ), 
            ), 
          ], 
        ),
      )
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async { 
    TextEditingController currentPasswordController = TextEditingController(); 
    TextEditingController newPasswordController = TextEditingController(); 
    return showDialog<void>( 
      context: context, 
      barrierDismissible: false, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text('Изменить пароль'), 
          content: SingleChildScrollView( 
            child: ListBody( 
              children: <Widget>[ 
                TextField( 
                  controller: currentPasswordController, 
                  decoration: InputDecoration( 
                    labelText: 'Текущий пароль', 
                  ), 
                  obscureText: true, 
                ), 
              ], 
            ), 
          ), 
          actions: <Widget>[ 
            TextButton( 
              child: Text('Отмена'), 
              onPressed: () { 
                Navigator.of(context).pop(); 
              }, 
            ), 
            TextButton( 
              child: Text('Далее'), 
              onPressed: () async { 
                String currentPassword = await getPassword(); 
                if (currentPasswordController.text == currentPassword) { 
                  Navigator.of(context).pop(); 
                  _showNewPasswordDialog(context, newPasswordController); 
                } else { 
                  // Обработка неверного пароля 
                } 
              }, 
            ), 
          ], 
        ); 
      }, 
    ); 
  } 
  Future<void> _showNewPasswordDialog(BuildContext context, TextEditingController newPasswordController) async { 
    return showDialog<void>( 
      context: context, 
      barrierDismissible: false, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text('Новый пароль'), 
          content: SingleChildScrollView( 
            child: ListBody( 
              children: <Widget>[ 
                TextField( 
                  controller: newPasswordController, 
                  decoration: InputDecoration( 
                    labelText: 'Новый пароль', 
                  ), 
                  obscureText: true, 
                ), 
              ], 
            ), 
          ), 
          actions: <Widget>[ 
            TextButton( 
              child: Text('Отмена'), 
              onPressed: () { 
                Navigator.of(context).pop(); 
              }, 
            ), 
            TextButton( 
              child: Text('Сохранить'), 
              onPressed: () { 
                updatePassword(newPasswordController.text); 
                Navigator.of(context).pop(); 
              }, 
            ), 
          ], 
        ); 
      }, 
    ); 
  } 
  Future<void> _showChangeUsernameDialog(BuildContext context) async { 
    TextEditingController currentPasswordController = TextEditingController(); 
    TextEditingController newUsernameController = TextEditingController(); 
    return showDialog<void>( 
      context: context, 
      barrierDismissible: false, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text('Изменить логин'), 
          content: SingleChildScrollView( 
            child: ListBody( 
              children: <Widget>[ 
                TextField( 
                  controller: 
                  currentPasswordController, 
                  decoration: InputDecoration( 
                    labelText: 'Текущий пароль', 
                  ), 
                  obscureText: true, 
                ), 
              ], 
            ), 
          ), 
          actions: <Widget>[ 
            TextButton( 
              child: Text('Отмена'), 
              onPressed: () { 
                Navigator.of(context).pop(); 
              }, 
            ), 
            TextButton( 
              child: Text('Далее'), 
              onPressed: () async { 
                String currentPassword = await getPassword(); 
                if (currentPasswordController.text == currentPassword) { 
                  Navigator.of(context).pop(); 
                  _showNewUsernameDialog(context, newUsernameController); 
                } else { 
                  // Обработка неверного пароля 
                } 
              }, 
            ), 
          ], 
        ); 
      }, 
    ); 
  } 
  Future<void> _showNewUsernameDialog(BuildContext context, TextEditingController newUsernameController) async { 
    return showDialog<void>( 
      context: context, 
      barrierDismissible: false, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text('Новый логин'), 
          content: SingleChildScrollView( 
            child: ListBody( 
              children: <Widget>[ 
                TextField( 
                  controller: newUsernameController, 
                  decoration: InputDecoration( 
                    labelText: 'Новый логин', 
                  ), 
                ), 
              ], 
            ), 
          ), 
          actions: <Widget>[ 
            TextButton( 
              child: Text('Отмена'), 
              onPressed: () { 
                Navigator.of(context).pop(); 
              }, 
            ), 
            TextButton( 
              child: Text('Сохранить'), 
              onPressed: () { 
                updateUsername(newUsernameController.text); 
                Navigator.of(context).pop(); 
              }, 
            ), 
          ], 
        ); 
      }, 
    ); 
  } 
  Future<void> _showDeleteUserDialog(BuildContext context) async { 
    return showDialog<void>( 
      context: context, 
      barrierDismissible: false, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text('Удалить пользователя'), 
          content: SingleChildScrollView( 
            child: ListBody( 
              children: <Widget>[ 
                Text('Вы уверены, что хотите удалить аккаунт? Это действие не может быть отменено.'), 
              ], 
            ), 
          ), 
          actions: <Widget>[ 
            TextButton( 
              child: Text('Отмена'), 
              onPressed: () { 
                Navigator.of(context).pop(); 
              }, 
            ), 
            TextButton( 
              child: Text('Удалить'), 
              onPressed: () { 
                deleteUser(context); 
                Navigator.of(context).pop(); 
              }, 
            ), 
          ], 
        ); 
      }, 
    ); 
  }
}