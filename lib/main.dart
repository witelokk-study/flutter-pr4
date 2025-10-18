import 'package:flutter/material.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatefulWidget {
  const BookApp({super.key});

  @override
  State<BookApp> createState() => _BookAppState();
}

class _BookAppState extends State<BookApp> {
  final List<String> _books = [
    "1984 — Джордж Оруэлл",
    "Мастер и Маргарита — Михаил Булгаков",
    "Преступление и наказание — Фёдор Достоевский",
  ];

  void _addBook() {
    setState(() {
      _books.add("Новая книга #${_books.length + 1}");
    });
  }

  void _removeBook(int index) {
    setState(() {
      _books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Column')),
        body: ColumnScreen(
          books: _books,
          onAdd: _addBook,
          onRemove: _removeBook,
        ),
      ),
    );
  }
}

class ColumnScreen extends StatelessWidget {
  final List<String> books;
  final VoidCallback onAdd;
  final Function(int) onRemove;

  const ColumnScreen({
    super.key,
    required this.books,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text('Добавить книгу'),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: books.asMap().entries.map((entry) {
                final index = entry.key;
                final book = entry.value;
                return ListTile(
                  title: Text(book),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemove(index),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
