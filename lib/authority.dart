import 'package:flutter/material.dart';

class AuthOption {
  final String title;
  final TextEditingController controller;

  AuthOption(this.title) : controller = TextEditingController();

  void dispose() {
    controller.dispose();
  }
}

class AuthOptionAdapter {
  final List<AuthOption> options;

  AuthOptionAdapter(this.options);

  List<Widget> getWidgets(double padding) {
    return options.map((option) {
      return Padding(
        padding: EdgeInsets.only(top: padding),
        child: TextField(
          controller: option.controller,
          decoration: InputDecoration(
            labelText: option.title,
            border: const UnderlineInputBorder(),
          ),
        ),
      );
    }).toList();
  }

  String getValue(String key) {
    for (var option in options) {
      if (option.title == key) {
        return option.controller.text;
      }
    }
    return '';
  }

  void dispose() {
    for (var option in options) {
      option.controller.clear();
    }
  }
}