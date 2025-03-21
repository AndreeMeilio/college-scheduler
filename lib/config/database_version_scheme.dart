
import 'package:sqflite/sqflite.dart';

class DatabaseVersionScheme {

  late Database _db;
  late int _version;

  DatabaseVersionScheme(Database db, int version): _db = db, _version = version;

  Future<void> databaseScheme() async{
    switch(_version){
      case 1:
        await databaseVersion_1();
        break;
      case 2:
        await databaseVersion_2();
        break;
    }
  }

  Future<void> databaseVersion_1() async{
    await _db.execute(
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
    await _db.execute(
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
    await _db.execute(
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
    await _db.execute(
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
    await _db.execute(
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
  }

  Future<void> databaseVersion_2() async{
    await _db.execute(
      """
        create table menu(
          id integer primary key autoincrement,
          name text,
          route text,
          isIncoming integer,
          parent_menu string,
          show_order integer,
          created_at text,
          updated_at text
        )
      """
    );

    await _db.transaction((trx) async{
      Batch batch = trx.batch();

      batch.insert("menu", {
        "name": "Logout",
        "route": "/logout",
        "isIncoming": 0,
        "show_order": 9,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Data Class",
        "route": "/class",
        "isIncoming": 0,
        "show_order": 1,
        "parent_menu": "data",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Change Password",
        "route": "/change-password",
        "isIncoming": 0,
        "show_order": 6,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Change Fullname Or Username",
        "route": "/change-fullname-or-username",
        "isIncoming": 0,
        "show_order": 7,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Login History",
        "route": "/login/history",
        "isIncoming": 0,
        "show_order": 8,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Data lecturer",
        "route": "/lecturer",
        "isIncoming": 0,
        "show_order": 2,
        "parent_menu": "data",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Event History",
        "route": "/events/history",
        "isIncoming": 0,
        "show_order": 3,
        "parent_menu": "data",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Reminder Event",
        "route": "-",
        "isIncoming": 1,
        "show_order": 4,
        "parent_menu": "notification",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "Reminder Input",
        "route": "-",
        "isIncoming": 1,
        "show_order": 5,
        "parent_menu": "notification",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });

      await batch.commit();
    });
  }
}