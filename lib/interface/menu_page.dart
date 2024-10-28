import 'package:flutter/material.dart';
import 'package:flutter_application_1/menu_item.dart';

class MenuPage {

  Widget createMenu(List<ItemMenu> menuItems) {
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
                      backgroundImage: const AssetImage('assets/user_icon.jpg'),
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
                    const Text(
                      'Имя пользователя', // Здесь будет отображаться имя пользователя
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