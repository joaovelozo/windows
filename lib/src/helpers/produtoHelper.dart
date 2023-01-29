import 'dart:io';
import 'package:i9/src/constants/produtoConstant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosHelper {
  ProdutosHelper._instance();
  static final ProdutosHelper db = ProdutosHelper._instance();
  late Database _database;
  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databasePath = directory.path + DATABASE_NAME;
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(CREATE_PRODUTO_TABLE);
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}
