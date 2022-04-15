import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swe/Misc/Strings.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/controller/transactionController.dart';
import 'package:swe/model/transaction.dart';

import '../model/account.dart';
import '../model/debt.dart';
import '../model/plannedPaymentModel.dart';

class TimerController {
  DateTime now = DateTime.now();
  DateFormat monthFormatter = DateFormat('MM');
  DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
  DateFormat dateFormatter = DateFormat('dd-MM-yyyy HH:mm');
  DateFormat dayFormatter = DateFormat('dd');
  String formattedMonth;
  String formattedDay ;
  String formattedTime;
  String formattedDate;

  static final TimerController instance = TimerController._init();
  static bool isChecked = false;

  static Database _database;

  TimerController._init();
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
    final max = await db.rawQuery("SELECT max(id) as max FROM PlannedPayment");
    return max[0]["max"];
  }
  Future<PlannedPayment> getSingleAccount(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      "PlannedPayment",
      columns: Debt.values,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PlannedPayment.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }



  Future<PlannedPayment> create(PlannedPayment plannedPayment) async {
    final db = await instance.database;

    final id = await db.insert('PlannedPayment', plannedPayment.toJsonMap());
    return plannedPayment.copy(id: id);
  }


  Future<List<PlannedPayment>> readAllRecords() async {
    final db = await instance.database;



    final result = await db.query('PlannedPayment');

    return result.map((json) => PlannedPayment.fromJson(json)).toList();
  }

  Future<int> update(PlannedPayment plannedPayment) async {
    final db = await instance.database;

    return db.update(
      'PlannedPayment',
      plannedPayment.toJsonMap(),
      where: 'id = ?',
      whereArgs: [plannedPayment.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'PlannedPayment',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<int> deleteAll() async {
    final db = await instance.database;

    return await   db.delete("PlannedPayment");

  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }





}