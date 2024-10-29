import 'package:flutter_application_1/database/bookdatabase.dart';
import 'package:flutter_application_1/global_values.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
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
CREATE TABLE users (
  user_id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL,
  password TEXT NOT NULL,
  book_table_address TEXT NOT NULL,
  total_books INTEGER NOT NULL,
  favorite_books INTEGER NOT NULL
)
''');
  }

  Future<void> addUser(String username, String password, String bookTableAddress) async {
    final db = await instance.database;

    await db.insert('users', {
      'username': username,
      'password': password,
      'book_table_address': '${username}_books',
      'total_books': 0,
      'favorite_books': 0,
    });
    bookTableName = '${username}_books';
    BookDatabase.instance.createUserBookTable();
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;

    return await db.query('users');
  }

  Future<Map<String, dynamic>?> getUserByLogin(String username) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> verifyUserPassword(String username, String password) async {
  final db = await instance.database;

  final result1 = await db.query(
    'users',
    where: 'username = ?',
    whereArgs: [username],
  );
  final result2 = await db.query(
    'users',
    where: 'password = ?',
    whereArgs: [password],
  );

  print("Result: $result1"); // Для отладки
  print("password: $password");
  return result1 == result2;
}

  Future<void> deleteUser(int id) async {
    final db = await instance.database;

    await db.delete(
      'users',
      where: 'user_id = ?',
      whereArgs: [id],
    );
  }
  Future<void> deleteAllUsers() async {
  final db = await instance.database;

  await db.delete(
    'users',
  );

  print('Все пользователи удалены');
}

  Future<void> incrementTotalBooks(int id) async {
    final db = await instance.database;

    await db.rawUpdate('''
UPDATE users
SET total_books = total_books + 1
WHERE user_id = ?
''', [id]);
  }

  Future<void> incrementFavoriteBooks(int id) async {
    final db = await instance.database;

    await db.rawUpdate('''
UPDATE users
SET favorite_books = favorite_books + 1
WHERE user_id = ?
''', [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}