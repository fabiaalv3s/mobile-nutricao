import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import '../components/classes/user.dart';

class SQLHelperUsers {
  static Future<sql.Database> db() async {
    return sql.openDatabase('Users.db', version: 1,
        //onOpen: createTables,
        onCreate: (sql.Database database, int version) async {
      debugPrint('***** Criando tabela *****');
      await createTables(database);
    });
  }

  static Future<void> dropDB() async {
    final db = await SQLHelperUsers.db();
    await db.execute('DROP TABLE Users');
    createTables(db);
    return; 
  }

  static Future<void> createTables(sql.Database database) async {
    debugPrint('***** Criando tabela *****');
    await database.execute('''
    CREATE TABLE Users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${UsersFields.name} TEXT,
      ${UsersFields.email} TEXT,
      ${UsersFields.password} TEXT,
      ${UsersFields.imagePath} TEXT,
      ${UsersFields.birthDate} INTEGER,
      ${UsersFields.hash} INTEGER,
      logged INTEGER NOT NULL
    )
''');
  }

  static Future<int> createItem(String name, String email, String password,
      String imagePath, int birthDate, int logged) async {
    // await dropDB();
    final db = await SQLHelperUsers.db();
    final data = {
      UsersFields.name: name,
      UsersFields.email: email,
      UsersFields.password: password,
      UsersFields.imagePath: imagePath,
      UsersFields.birthDate: birthDate,
      UsersFields.hash: (email.hashCode * password.hashCode),
      'logged': logged
    };
    final id = await db.insert('Users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperUsers.db();
    return db.query('Users', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItemByID(int id) async {
    final db = await SQLHelperUsers.db();
    return db.query('Users', where: 'id = ?', whereArgs: [id.toString()]);
  }

  static Future<int> updateItem(String nome, String password, int id) async {
    final db = await SQLHelperUsers.db();

    final item = await SQLHelperUsers.getItemByID(id);

    final data = {
      'name': nome,
      'email': item[0]['email'],
      'password': password,
      'imagePath': item[0]['imagePath'],
      UsersFields.birthDate: item[0]['birthDate'],
      'hashCode': (item[0]['email'].hashCode * password.hashCode),
      'logged': 0
    };

    final result =
        await db.update('Users', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperUsers.db();
    debugPrint('Deletando item com o ID: $id');
    try {
      await db.delete('Users', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado ao tentar deletar o item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> getItemsByName(String name) async {
    final db = await SQLHelperUsers.db();
    return db
        .rawQuery('SELECT * FROM Users WHERE name like "%$name%" ORDER BY id');
  }

    static Future<int> userLogin(int id) async {
    final db = await SQLHelperUsers.db();

    final item = await SQLHelperUsers.getItemByID(id);

    final data = {
      'name': item[0]['name'],
      'email': item[0]['email'],
      'password': item[0]['password'],
      'imagePath': item[0]['imagePath'],
      UsersFields.birthDate: item[0]['birthDate'],
      'hashCode': item[0]['hashCode'],
      'logged': 1
    };

    final result =
        await db.update('Users', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

    static Future<int> userLogout(id) async {
    final db = await SQLHelperUsers.db();

    final item = await SQLHelperUsers.getItemByID(id);

    final data = {
      'name': item[0]['name'],
      'email': item[0]['email'],
      'password': item[0]['password'],
      'imagePath': item[0]['imagePath'],
      UsersFields.birthDate: item[0]['birthDate'],
      'hashCode': item[0]['hashCode'],
      'logged': 0
    };

    final result =
        await db.update('Users', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

}
