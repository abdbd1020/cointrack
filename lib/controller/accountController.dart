import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swe/model/account.dart';

class AccountController {
  static final AccountController instance = AccountController._init();

  static Database _database;

  AccountController._init();
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
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE Accounts ( 
  id $idType, 
  name $textType,
  amount $integerType,
  type $textType

  )
''');
  }


//   Future _createDB(Database db, int version) async {
//     final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     final textType = 'TEXT NOT NULL';
//     final boolType = 'BOOLEAN NOT NULL';
//     final integerType = 'INTEGER NOT NULL';
//
//     await db.execute('''
// CREATE TABLE $tableNotes (
//   ${NoteFields.id} $idType,
//   ${NoteFields.isImportant} $boolType,
//   ${NoteFields.number} $integerType,
//   ${NoteFields.title} $textType,
//   ${NoteFields.description} $textType,
//   ${NoteFields.time} $textType
//   )
// ''');
//   }

  Future<Account> create(Account account) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert('Accounts', account.toJsonMap());
    return account.copy(id: id);
  }


  Future<List<Account>> readAllAccounts() async {
    final db = await instance.database;

    final orderBy = 'time ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query('Accounts');

    return result.map((json) => Account.fromJson(json)).toList();
  }

  Future<int> update(Account account) async {
    final db = await instance.database;

    return db.update(
      'Accounts',
      account.toJsonMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'Accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteAll() async {
    final db = await instance.database;

    return await   db.delete("Accounts");

  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }


  Future<void> insertDog(Account account) async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'account.db'),
      // When the database is first created, create a table to store dogs.

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'Account',
      account.toJsonMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Account>> dogs() async {

    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'account.db'),
      // When the database is first created, create a table to store dogs.

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('account');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Account(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['age'],
          type: maps[i]['type']
      );
    });
  }
}