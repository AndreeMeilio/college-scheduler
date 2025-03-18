import 'package:college_scheduler/config/constants_value.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {

  String? _databasePath;
  Database? _database;

  Future<Database> getDB() async{
    if (_database != null) return _database!;

    String pathDatabase = await getDatabasesPath();
    _databasePath = join(pathDatabase, ConstansValue.databaseFilename);
    _database = await openDatabase(
      _databasePath!,
      version: ConstansValue.databaseVersion,
      onCreate: (Database db, int version) async{
        await db.execute(
          """
            create table users(
              id integer primary key autoincrement,
              device_id text,
              fullname text,
              username text,
              password text,
              salt text,
              created_at text,
              updated_at text
            )
          """
        );
        await db.execute(
          """
            create table events(
              id integer primary key autoincrement,
              user_id integer,
              date_of_event text,
              title text,
              start_hour text,
              end_hour text,
              location text,
              class_name text,
              description text,
              priority text,
              status text,
              created_at text,
              updated_at text
            )
          """
        );
        await db.execute(
          """
            create table class(
              id integer primary key autoincrement,
              user_id integer,
              name text,
              start_hour text,
              end_hour text,
              day text,
              lecturer_name text,
              created_at text,
              updated_at text
            )
          """
        );
        await db.execute(
          """
            create table logs(
              id integer primary key autoincrement,
              user_id integer,
              action_name text,
              table_action text,
              description text,
              created_at text,
              updated_at text
            )
          """
        );
        await db.execute(
          """
            create table lecturer(
              id integer primary key autoincrement,
              user_id integer,
              name text,
              created_at text,
              updated_at text
            )
          """
        );
      },
    );

    return _database!;
  }
}

