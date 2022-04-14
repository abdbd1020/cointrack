import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/debt.dart';

class DebtController {
  static final DebtController instance = DebtController._init();

  static Database _database;

  DebtController._init();
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('account.db');
    return _database;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {

  }

  Future<int> maxItem() async {
    final db = await instance.database;
    final max = await db.rawQuery("SELECT max(id) as max FROM Debt");
    return max[0]["max"];
  }




  Future<Debt> create(Debt debt) async {
    final db = await instance.database;

    final id = await db.insert('Debt', debt.toJsonMap());
    return debt.copy(id: id);
  }


  Future<List<Debt>> readAllRecords() async {
    final db = await instance.database;



    final result = await db.query('Debt');

    return result.map((json) => Debt.fromJson(json)).toList();
  }

  Future<int> update(Debt debt) async {
    final db = await instance.database;

    return db.update(
      'Debt',
      debt.toJsonMap(),
      where: 'id = ?',
      whereArgs: [debt.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'Debt',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await   db.delete("Debt");

  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }





}