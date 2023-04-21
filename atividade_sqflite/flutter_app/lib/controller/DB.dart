import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

Future<Database> openBanco() async {
  var dataBasePath = await getDatabasesPath();
  String path = join(dataBasePath, 'banco.db');
  var bd =
      await openDatabase(path, version: 1, onCreate: (db, versaoRecente) async {
    String sql =
        "CREATE TABLE contatos (id INTEGER PRIMARY KEY AUTOINCREMENT, login TEXT, senha TEXT)";
    await db.execute(sql);
  });
  return bd;
}

Future<List<Map<String, dynamic>>> obterContatos() async {
  final db = await openBanco();
  return db.query('contatos');
}

Future<void> apagarBanco() async {
  var dataBasePath = await getDatabasesPath();
  String path = join(dataBasePath, 'banco.db');
  await deleteDatabase(path);
}
