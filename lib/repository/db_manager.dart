

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    // Get the device's documents directory using path_provider
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "caretodo.db");

    // Open or create the database at the specified path
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  // Create the necessary tables in the database
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE care_todo(id INTEGER PRIMARY KEY, uid TEXT, title TEXT, description TEXT, status TEXT)");
  }

  // Example method to insert data into the database
  Future<int> insertData(Map<String, dynamic> data) async {
    var dbClient = await db;
    return await dbClient.insert("care_todo", data);
  }

  // Example method to fetch data from the database
  Future<List<Map<String, dynamic>>> getData() async {
    var dbClient = await db;
    return await dbClient.query("care_todo");
  }

  Future<int> updateData(int id, Map<String, dynamic> newData) async {
    var dbClient = await db;
    return await dbClient.update(
      "care_todo",
      newData,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      "care_todo",
      where: "id = ?",
      whereArgs: [id],
    );
  }





}
