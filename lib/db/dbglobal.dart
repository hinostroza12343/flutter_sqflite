import 'dart:io';

import 'package:esekuele_repaso/utils/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBGlobal {
  static Database? myDatabase;
  static final DBGlobal db = DBGlobal._();

  DBGlobal._();

  Future<Database?> get getdatabase async {
    if (myDatabase != null) return myDatabase;

    myDatabase = await initDb();
    return myDatabase;
  }

  initDb() async {
    Directory documentDirectoy = await getApplicationDocumentsDirectory();
    final path = join(documentDirectoy.path, "PracticaDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int vesion) async {
      await db.execute(
          "CREATE TABLE Demo(id INTEGER PRIMARY KEY AUTOINCREMENT,nomb TEXT,desc TEXT,img TEXT)");
    });
  }

  insert(Model model) async {
    final db = await getdatabase;
    final res = await db!.insert("Demo", model.convertiraMap());
    // print(res);
    return res;
  }

  update(Model model) async {
    final db = await getdatabase;
    final res = await db!.update("Demo",model.convertiraMap(),where: "id=${model.id}");
    return res;
  }

  delete(int id) async {
    final db = await getdatabase;
    final res = await db!.delete("Demo", where: "id=$id");
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await getdatabase;
    final List<Map<String, dynamic>> res = await db!.query("Demo");
    // print(res);
    return res;
  }
}
