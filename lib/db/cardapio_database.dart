import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import '../components/classes/cardapio.dart';

class SQLHelperCard{
    static Future<sql.Database> db() async {
    return sql.openDatabase(
      'cardapio.db',
      version: 1,
      //onOpen: createTables,
      onCreate: (sql.Database database, int version) async {
        debugPrint('***** Criando tabela *****');
        await createTables(database);
      }
    );
  }

  static Future<List<Map<String, Object?>>> dropDB() async {
    final db = await SQLHelperCard.db();
    return db.rawQuery('DROP DATABASE cardapio.db');
  }

  static Future<void> createTables(sql.Database database) async {
    debugPrint('***** Criando tabela *****');
    await database.execute('''
    CREATE TABLE cardapio(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${CardapioFields.name} TEXT,
      ${CardapioFields.cafeId1} INTEGER NOT NULL,
      ${CardapioFields.cafeId2} INTEGER NOT NULL,
      ${CardapioFields.cafeId3} INTEGER NOT NULL,
      ${CardapioFields.almocoId1} INTEGER NOT NULL,
      ${CardapioFields.almocoId2} INTEGER NOT NULL,
      ${CardapioFields.almocoId3} INTEGER NOT NULL,
      ${CardapioFields.almocoId4} INTEGER NOT NULL,
      ${CardapioFields.almocoId5} INTEGER NOT NULL,
      ${CardapioFields.jantarId1} INTEGER NOT NULL,
      ${CardapioFields.jantarId2} INTEGER NOT NULL,
      ${CardapioFields.jantarId3} INTEGER NOT NULL,
      ${CardapioFields.jantarId4} INTEGER NOT NULL
    )
''');
  }

  static Future<int> createItem(Cardapio cardapio) async {
    final db = await SQLHelperCard.db();
    final data = cardapio.toJson();
    final id = await db.insert('cardapio', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperCard.db();
    return db.query('cardapio', orderBy: 'id');
  }
  static Future<List<Map<String, dynamic>>> getItemByID(int id) async {
    final db = await SQLHelperCard.db();
    return db.query('cardapio', where: 'id = ?', whereArgs: [id.toString()]);
  }

  static Future<int> updateItem(Cardapio cardapio, int id) async {
    final db = await SQLHelperCard.db();
    //final item = await SQLHelperCard.getItemByID(id);

    final data = cardapio.toJson();

    final result = await db.update('cardapio', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperCard.db();
    debugPrint('Deletando item com o ID: $id');
    try {
      await db.delete('cardapio',
      where: 'id = ?', whereArgs: [id]
      );
    } catch (err) {
      debugPrint("Algo deu errado ao tentar deletar o item: $err");
    }
  }
}


