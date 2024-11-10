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
        return db.execute(
          '''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> cacheUser(Map<String, dynamic>? userData) async {
  try {
    if (userData != null) {
      // User data found, now insert it into SQLite
      final db = await database;

      // Check if the user already exists in the local database
      List<Map<String, dynamic>> existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [userData['email']],
      );

      if (existingUser.isEmpty) {
        // If user doesn't exist, insert the new user data
        await db.insert(
          'users',
          {
            'email': userData['email'], // Ensure email is a string
            'password': userData['password'], // Assuming password is hashed in Firebase
          },
          conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
        );
      } else {
        // Optionally update the user record if needed (e.g., if password changes)
        await db.update(
          'users',
          {
            'password': userData['password'],
          },
          where: 'email = ?',
          whereArgs: [userData['email']], // Ensure email is passed as a list for whereArgs
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

  Future<String?> getPasswordByEmail(String email) async {
    final db = await database;

    // Execute the query and retrieve the 'password' field
    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['password'],  // Only fetch the 'password' column
      where: 'email = ?',
      whereArgs: [email],
    );

    // If the result is not empty, return the password from the first row
    return result.isNotEmpty ? result.first['password'] : null;
  }

}
