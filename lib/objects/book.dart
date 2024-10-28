import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_values.dart';

class Book {
  final String title;
  final String author;
  bool isFavorite;

  Book({
    required this.title,
    required this.author,
    required this.isFavorite,
  });

  Widget createBookWidget(Function setState) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          isFavorite ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
            if (isFavorite) favorBooks.add(this);
            if (!isFavorite) favorBooks.remove(this);
          });
        },
      ),
      title: Text(title),
      subtitle: Text('Автор: $author'),
      onTap: () {

      }
    );
  }
}