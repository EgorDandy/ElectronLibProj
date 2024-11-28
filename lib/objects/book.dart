import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/interface/pdf_viewer_page.dart';

class Book {
  final String title;
  final String author;
  final String? path;
  bool isFavorite;

  Book({
    required this.title,
    required this.author,
    required this.path,
    required this.isFavorite,
  });

  Widget createBookWidget(Function setState, BuildContext context) {
    return Dismissible(
      key: Key(title),
      background: Container(
        color: Colors.orange,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.star, color: Colors.white, size: 40),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      confirmDismiss: (direction) async { 
        if (direction == DismissDirection.startToEnd) { 
          // Свайп вправо - просто меняем состояние избранного 
          setState(() { 
            isFavorite = !isFavorite; 
            if (isFavorite) { 
              favorBooks.add(this); 
            } else { 
              favorBooks.remove(this); 
            } 
          }); 
          return false; 
          // Возвращает виджет на место 
        } else if (direction == DismissDirection.endToStart) { 
          books.remove(this);
          if (isFavorite) favorBooks.remove(this);
          return true; 
          // Удаляет виджет из дерева виджетов 
        } 
        return false; 
      },
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
              if (isFavorite) {
                favorBooks.add(this);
              } else {
                favorBooks.remove(this);
              }
            });
          },
        ),
        title: Text(title),
        subtitle: Text('Автор: $author'),
        onTap: () {
          Navigator.push( 
            context, 
            MaterialPageRoute( 
              builder: (context) => PDFViewerPage(filePath: path, name: title), 
            ), 
          );
        },
      ),
    );
  }
}