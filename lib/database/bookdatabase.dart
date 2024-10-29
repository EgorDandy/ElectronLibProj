import 'package:flutter_application_1/global_values.dart';
import 'package:flutter_application_1/objects/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BookDatabase {
  static final BookDatabase instance = BookDatabase._init();

  static Database? _database;

  BookDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  author TEXT NOT NULL,
  pdfPath TEXT NOT NULL,
  isFavor INTEGER
)
''');
  }

  Future<void> addBook(String title, String author, String pdfPath) async {
    final db = await instance.database;

    await db.insert(bookTableName, {
      'title': title,
      'author': author,
      'pdfPath': pdfPath,
      'isFavor': 0
    });
  }

  Future<void> createUserBookTable() async {
    final db = await instance.database;

    await db.execute('''
CREATE TABLE $bookTableName (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  author TEXT NOT NULL,
  pdfPath TEXT NOT NULL,
  isFavor INTEGER
)
''');
  }

  Future<List<Book>> getAllBooks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(bookTableName);

    return List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['book_title'],
        author: maps[i]['author'],
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });
  }

  Future<Map<String, dynamic>?> getBookById(int id) async {
    final db = await instance.database;

    final result = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteBook(int id) async {
    final db = await instance.database;

    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}