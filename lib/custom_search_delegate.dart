import 'package:flutter/material.dart';
import 'package:flutter_application_1/objects/book.dart';
import 'global_values.dart';

class CustomSearchDelegate extends SearchDelegate {
  void Function(VoidCallback fn) setState;
  List<Book> baseList;
  CustomSearchDelegate(this.setState, this.baseList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> results;
    print('ЗАПРОС РАВЕН = $query.');
    if (query != '') {
      results = baseList.where((book) => book.title.contains(query)).toList();
    }
    else {
      results = List.from(baseList);
    }
    print('РЕЗУЛЬТАТ РАВЕН = $baseList');
    // Закрываем страницу поиска
    Future.delayed(Duration.zero, () {
      setState(() {
        searchList = List.from(results);
      });
      // ignore: use_build_context_synchronously
      close(context, null);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          decoration: const InputDecoration(
            hintText: 'Введите запрос для поиска...',
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (text) {    
          },
        );
      },
    );
  }
}