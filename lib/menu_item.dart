import 'package:flutter/material.dart';

class ItemMenu{
  IconData icon;
  String value;
  Function()? func;

  ItemMenu({
    required this.icon, 
    required this.value, 
    required this.func
  });

  Widget getMenuItem() {
    return ListTile(
      leading: Icon(icon),
      title: Text(value),
      onTap: () {
        func!();
      },
    );
  }
}