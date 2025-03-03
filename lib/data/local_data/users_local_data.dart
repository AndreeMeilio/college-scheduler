
import 'dart:convert';
import 'dart:math';

import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/data/models/users_model.dart';
import 'package:college_scheduler/utils/random_string.dart';
import 'package:crypto/crypto.dart';

class UsersLocalData {
  final DatabaseConfig _database;

  UsersLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<UsersModelResponse> getAllData() async{
    final db = await _database.getDB();

    try {
      final result = await db.rawQuery(
        "SELECT * FROM users"
      );

      print("FROM USER LOCAL DATA : $result");

      return UsersModelResponse(
        code: "00",
        message: "Berhasil get data",
        data: []
      );
    } catch (e){
      return UsersModelResponse(
        code: "01",
        message: "${e}",
        data: []
      );
    }
  }

  Future<UsersModelResponse> registerAccount({
    required String fullname,
    required String username,
    required String password
  }) async{

    final saltPassword = RandomStringUtils.generateString(length: 64);
    final hashPassword = utf8.encode(password + saltPassword);
    final digest = sha512256.convert(hashPassword);

    final db = await _database.getDB();

    try {
      await db.transaction((txn) async{
        await txn.insert('users', {
          "fullname" : fullname,
          "username": username,
          "password": digest,
          "salt": saltPassword,
          "created_at": DateTime.now().toString(),
          "updated_at": DateTime.now().toString()
        });
      });

      return UsersModelResponse(
        code: "00",
        message: "Berhasil Menambah Data Baru",
        data: []
      );
    } catch (e){
      print(e);
      return UsersModelResponse(
        code: "01",
        message: e.toString(),
        data: []
      );
    }
  }
}