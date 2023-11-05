import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import '../components/classes/alimento.dart';

class SQLHelperAlimentos{
    static Future<sql.Database> db() async {
    return sql.openDatabase(
      'alimentos.db',
      version: 1,
      //onOpen: createTables,
      onCreate: (sql.Database database, int version) async {
        debugPrint('***** Criando tabela *****');
        await createTables(database);
      }
    );
  }

  static Future<List<Map<String, Object?>>> dropDB() async {
    final db = await SQLHelperAlimentos.db();
    return db.rawQuery('DROP DATABASE alimentos.db');
  }

  static Future<void> createTables(sql.Database database) async {
    debugPrint('***** Criando tabela *****');
    await database.execute('''
    CREATE TABLE alimentos(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${AlimentosFields.nome} TEXT,
      ${AlimentosFields.fotoBytes} TEXT,
      ${AlimentosFields.categoria} TEXT,
      ${AlimentosFields.tipo} TEXT,
      ${AlimentosFields.pdfPath} TEXT
    )
''');
  }

  static Future<int> createItem(Alimento alimento) async {
    final db = await SQLHelperAlimentos.db();
    final data = alimento.toJson();
    final id = await db.insert('alimentos', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperAlimentos.db();
    return db.query('alimentos', orderBy: 'id');
  }
  static Future<List<Map<String, dynamic>>> getItemByID(int id) async {
    final db = await SQLHelperAlimentos.db();
    return db.query('alimentos', where: 'id = ?', whereArgs: [id.toString()]);
  }

  static Future<int> updateItem(String nome, String categoria, String tipo, int id) async {
    final db = await SQLHelperAlimentos.db();

    final item = await SQLHelperAlimentos.getItemByID(id);

    final data = {
      'nome': nome,
      'fotoBytes': item[0]['fotoBytes'],
      'categoria': categoria,
      'tipo': tipo,
    };

    final result = await db.update('alimentos', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

static Future<void> deleteItem(int id) async {
  final db = await SQLHelperAlimentos.db();
  debugPrint('Deletando item com o ID: $id');
  try {
    await db.delete(
      'alimentos',
      where: 'id = ?',
      whereArgs: [id],
    );
    debugPrint('Item com ID: $id foi deletado com sucesso.');
  } catch (err) {
    debugPrint("Algo deu errado ao tentar deletar o item: $err");
  }
}

  static Future<List<Map<String, dynamic>>> getItemsByName(String name) async {
    final db = await SQLHelperAlimentos.db();
    return db.rawQuery('SELECT * FROM alimentos WHERE nome like "%$name%" ORDER BY id');
}
}

