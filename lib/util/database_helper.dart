import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          '''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            name TEXT,
            password TEXT NOT NULL
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Method to cache user email
  Future<void> cacheEmail(String email) async {
    final db = await database;
    await db.insert(
      'users',
      {'email': email},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

    Future<void> cacheName(String name) async {
    final db = await database;
    await db.insert(
      'users',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to retrieve the cached email
  Future<String> getCachedEmail() async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['email'],
      limit: 1,
    );
    return result.isNotEmpty ? result.first['email'] as String : '';
  }

    Future<String> getCachedName() async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['name'],
      limit: 1,
    );
    return result.isNotEmpty ? result.first['name'] as String : '';
  }


  // Method to cache user data
  Future<void> cacheUser(Map<String, dynamic>? userData) async {
    try {
      if (userData != null) {
        final db = await database;

        // Check if the user already exists in the local database
        List<Map<String, dynamic>> existingUser = await db.query(
          'users',
          where: 'email = ?',
          whereArgs: [userData['email']],
        );

        if (existingUser.isEmpty) {
          // Insert the new user data if user doesn't exist
          await db.insert(
            'users',
            {
              'email': userData['email'],
              'name': userData['name'],
              'password': userData['password'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } else {
          // Update the user record if password changes
          await db.update(
            'users',
            {
              'password': userData['password'],
            },
            where: 'email = ?',
            whereArgs: [userData['email']],
          );
        }
      } else {
        print("User not found in Firebase.");
      }
    } catch (e) {
      print("Error caching user: $e");
    }
  }

  // Method to validate user credentials
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Method to get cached password by email
  Future<String?> getPasswordByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['password'],
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first['password'] as String? : null;
  }
}
