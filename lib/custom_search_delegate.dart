import 'package:flutter/material.dart';
import 'global_values.dart';

class CustomSearchDelegate extends SearchDelegate {
  void Function(VoidCallback fn) setState;
  CustomSearchDelegate(this.setState);

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
    final results = books.where((book) => book.title.contains(query)).toList();
  
  // Закрываем страницу поиска
  Future.delayed(Duration.zero, () {
    setState(() {
      searchList = results;
      books = List.from(searchList);
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