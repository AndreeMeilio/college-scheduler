import 'package:college_scheduler/config/constants_value.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {

  String? _databasePath;
  Database? _database;

  Future<Database> getDB() async{
    if (_database != null) return Future.value(_database);

    _databasePath = join(await getDatabasesPath(), ConstansValue.databaseFilename);
    _database = await openDatabase(
      _databasePath!,
      version: ConstansValue.databaseVersion,
      onCreate: (Database db, int version) async{
        await db.execute(
          """
            create table users(
              id integer primary key autoincrement,
              fullname varchar(25),
              username varchar(25),
              password longtext,
              salt longtext,
              created_at timestamp,
              updated_at timestamp
            )
          """
        );
        await db.execute(
          """
            create table events(
              date_of_event date,
              title varchar(50),
              start_hour time,
              end_hour time,
              description text,
              priority varchar(10),
              status varchar(10),
              created_at timestamp,
              updated_at timestamp
            )
          """
        );
      }
    );

    return _database!;
  }
}

