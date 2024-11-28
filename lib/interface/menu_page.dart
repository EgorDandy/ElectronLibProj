import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/objects/menu_item.dart';

class MenuPage {

  Widget createMenu(List<ItemMenu> menuItems) {
    String login = curUser['username'];
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              child: SizedBox(
                height: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/user_icon.jpg'),
                      child: ClipOval(
                      child: Image.asset(
                        'assets/user_icon.jpg',
                        fit: BoxFit.cover, // Подгоняем размер фото
                        width: 90,
                        height: 90,
                      ),
                      ), // Здесь можно указать путь к фото пользователя
                    ),
                    const SizedBox(height: 10),
                    Text(
                      login, // Здесь будет отображаться имя пользователя
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (ItemMenu item in menuItems) item.getMenuItem()
          ],
        ),
    );
  }  
}