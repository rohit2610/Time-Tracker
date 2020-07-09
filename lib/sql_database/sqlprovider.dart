import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_tracker/models/activity.dart';

class SQLProvider {
  SQLProvider._();
  static final SQLProvider db = SQLProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print("HERE");
      return _database;
    }

    _database = await initDB();
    //await insertDatabase(_database);
    return _database;
  }

  initDB() async {
    String path = p.join(await getDatabasesPath(), "ActivityDB.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE activity ("
            "id TEXT PRIMARY KEY,"
            "startTime TEXT,"
            "endTime TEXT,"
            "date TEXT,"
            "timeInSeconds INTEGER"
            ")");
      },
    );
  }

  Future<List<Activity>> getAllActivity() async {
    final db = await database;

    //var ans = await db.rawQuery("DESCRIBE activity");
    List<Map> results = await db.rawQuery("SELECT * FROM activity");
    //print(results);
    List<Activity> activities = [];

    results.forEach((element) {
      Activity activity = Activity.fromMap(element);
      activities.add(activity);
      //print(activities);
    });

    return activities.reversed.toList();
  }

  insert(Activity activity) async {
    final db = await database;
    var result = await db.insert('activity', activity.toMap());
    //print(result);
    return result;
  }
}
