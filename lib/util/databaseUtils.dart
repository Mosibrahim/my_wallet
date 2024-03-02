import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseUtils {
  static final databaseFactory = databaseFactoryFfi;

  static getDBPath() async {
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();
    String dbPath = p.join(appDocumentsDir.path, "databases", "wallet.db");
    return dbPath;
  }

  static createUserTable() async {
    var db = await databaseFactory.openDatabase(await getDBPath());
    try {
      await db.query("User");
    } catch (e) {
      await db.execute('''
  CREATE TABLE User (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      amount REAL,
      lastTransactionAmount REAL,
      lastTransactionDate TEXT
  )
  ''');
    }
    await db.close();
  }

  static fetchUsers() async {
    var db = await databaseFactory.openDatabase(await getDBPath());
    var result = await db.query('User');
    await db.close();
    return result;
  }

  static insertUser(Map<String, Object?> userMap) async {
    var db = await databaseFactory.openDatabase(await getDBPath());
    int id = await db.insert('User', userMap);
    await db.close();
    return id;
  }
}
