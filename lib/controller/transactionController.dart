import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swe/model/transaction.dart';

class TransactionController {
  static final TransactionController instance = TransactionController._init();

  static Database _database;

  TransactionController._init();
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




  Future<TransactionModel> create(TransactionModel transaction) async {
    final db = await instance.database;

    final id = await db.insert('Transactions', transaction.toJsonMap());
    return transaction.copy(id: id);
  }


  Future<List<TransactionModel>> readAllRecords() async {
    final db = await instance.database;



    final result = await db.query('Transactions');

    return result.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<int> update(TransactionModel transaction) async {
    final db = await instance.database;

    return db.update(
      'Transactions',
      transaction.toJsonMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'Transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteAll() async {
    final db = await instance.database;

    return await   db.delete("Transactions");

  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }



}