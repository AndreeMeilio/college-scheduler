
import 'dart:convert';
import 'dart:math';

import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/data/models/users_model.dart';
import 'package:college_scheduler/utils/info_device.dart';
import 'package:college_scheduler/utils/random_string.dart';
import 'package:crypto/crypto.dart';

class UsersLocalData {
  final DatabaseConfig _database;

  UsersLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<UsersModelResponse> login({
    required String username,
    required String password,
  }) async{
    final db = await _database.getDB();

    try {
      final dataLocalByUsername = await db.transaction<List>((trx) async{
        List<Map> resultQuery = List.from(await trx.query('users', where: 'username = ?', whereArgs: [username]));

        List<Map> result = List.from(resultQuery);

        return result;
      });

      if (dataLocalByUsername.isNotEmpty){

        final dataUser = dataLocalByUsername.first;
        final hashPassword = utf8.encode(password + dataUser["salt"]);

        if (sha512256.convert(hashPassword).toString() == dataUser["password"]){
          final shared = SharedPreferenceConfig();
          await shared.setInt(
            key: ConstansValue.user_id,
            value: dataUser["id"]
          );

          await shared.setString(
            key: ConstansValue.fingerprint_id,
            value: dataUser["device_id"]
          );

          await shared.setString(
            key: ConstansValue.username,
            value: dataUser["username"]
          );

          return UsersModelResponse(
            code: "00",
            message: "Welcome back bro, it's nice seeing you again (:",
            data: List.from([
              UsersModel(
                id: dataUser["id"],
                fullname: dataUser["fullname"],
                deviceId: dataUser["device_id"],
                password: sha512256.convert(hashPassword).toString(),
                salt: dataUser["salt"],
                username: dataUser["username"],
                createdAt: DateTime.parse(dataUser["created_at"]),
                updatedAt: DateTime.parse(dataUser["updated_at"])
              )
            ])
          );
        } else {
          return UsersModelResponse(
            code: "01",
            message: "Credentials not found in our database",
            data: []
          );
        }
      } else {
        return UsersModelResponse(
          code: "01",
          message: "Credentials not found in our database",
          data: []
        );
      }
    } catch (e){
      print(e);
      return UsersModelResponse(
        code: "01",
        message: "There's a problem trying to login your account i am sorry );",
        data: []
      );
    }
  }

  Future<UsersModelResponse> loginWithFingerprint() async{
    final db = await _database.getDB();

    try {
      final deviceInfo = await InfoDeviceUtils.getAndroidInfo();
      final dataLocalByUsername = await db.transaction<List>((trx) async{
        List<Map> resultQuery = List.from(await trx.query('users', where: 'device_id like ?', whereArgs: [deviceInfo.fingerprint]));

        List<Map> result = List.from(resultQuery);

        print(result);

        return result;
      });

      if (dataLocalByUsername.isNotEmpty){

        final dataUser = dataLocalByUsername.first;

        final shared = SharedPreferenceConfig();
        await shared.setInt(
          key: ConstansValue.user_id,
          value: dataUser["id"]
        );

        await shared.setString(
          key: ConstansValue.fingerprint_id,
          value: dataUser["device_id"]
        );

        return UsersModelResponse(
          code: "00",
          message: "Welcome back bro, it's nice seeing you again (:",
          data: List.from([
            UsersModel(
              id: dataUser["id"],
              fullname: dataUser["fullname"],
              deviceId: dataUser["device_id"],
              password: dataUser["password"],
              salt: dataUser["salt"],
              username: dataUser["username"],
              createdAt: DateTime.parse(dataUser["created_at"]),
              updatedAt: DateTime.parse(dataUser["updated_at"])
            )
          ])
        );
      } else {
        return UsersModelResponse(
          code: "01",
          message: "Credentials not found in our database",
          data: []
        );
      }
    } catch (e){
      print(e);
      return UsersModelResponse(
        code: "01",
        message: "There's a problem trying to login your account i am sorry );",
        data: []
      );
    }
  }

  Future<ResponseGeneral<int>> registerAccount({
    required String fullname,
    required String username,
    required String password
  }) async{

    final saltPassword = RandomStringUtils.generateString(length: 64);
    final hashPassword = utf8.encode(password + saltPassword);
    final digest = sha512256.convert(hashPassword.toList());
    final deviceAndroid = await InfoDeviceUtils.getAndroidInfo();

    final db = await _database.getDB();

    bool isAccountWithUsernameExist = false;

    try {
      final result = await db.transaction<int>((txn) async{

        final checkAccountWithUsernameQuery = await txn.query("users", where: 'username = ?', whereArgs: [username]);

        if (checkAccountWithUsernameQuery.isNotEmpty){
          isAccountWithUsernameExist = true;

          return -1;
        } else {
          isAccountWithUsernameExist = false;

          final resultInsert = await txn.insert('users', {
            "fullname" : fullname,
            "username": username,
            "device_id": deviceAndroid.fingerprint.toString(),
            "password": digest.toString(),
            "salt": saltPassword,
            "created_at": DateTime.now().toString(),
            "updated_at": DateTime.now().toString()
          });

          return resultInsert;
        }
      });

      if (result >= 1){
        return ResponseGeneral(
          code: "00",
          message: "Your account has been successfully created",
          data: result
        );
      } else if (isAccountWithUsernameExist){
        return ResponseGeneral(
          code: "01",
          message: "Username has been used by others, please change it",
          data: result
        );
      } else {
        return ResponseGeneral(
          code: "01",
          message: "There's a problem creating your account i am sorry );",
          data: result
        );
      }
    } catch (e){
      print(e);
      return ResponseGeneral(
        code: "01",
        message: "There's a problem creating your account i am sorry );",
        data: 0
      );
    }
  }

  Future<ResponseGeneral<int>> changePassword({
    required String oldPassword,
    required String newPassword
  }) async{
    final db = await _database.getDB();
    final shared = SharedPreferenceConfig();
  
    try{
      final result = await db.transaction<ResponseGeneral<int>>((trx) async{
        final username = await shared.getString(key: ConstansValue.username);

        final checkUserExist = await trx.query("users", where: 'username = ?', whereArgs: [username]);
        
        if (checkUserExist.isNotEmpty){
          final dataUser = checkUserExist.first;

          final hashPassword = utf8.encode(oldPassword + dataUser["salt"].toString());
          final digest = sha512256.convert(hashPassword.toList());

          if (digest.toString() == dataUser["password"]){
            final hashNewPassword = utf8.encode(newPassword + dataUser["salt"].toString());
            final digestNewPassword = sha512256.convert(hashNewPassword.toList());

            final resultQueryUpdate = await trx.update("users", {
              "password" : digestNewPassword.toString()
            }, where: 'username = ?', whereArgs: [username]);

            if (resultQueryUpdate >= 1){
              return ResponseGeneral(
                code: "00",
                data: resultQueryUpdate,
                message: "Changing password successfully, please login again"
              );
            } else {
              return ResponseGeneral(
                code: "01",
                data: -1,
                message: "Updating your password failed, i am sorry!"
              );
            }
          } else {
            return ResponseGeneral(
              code: "01",
              data: -1,
              message: "Old password doesn't match with our database"
            );
          }
        } else {
          return ResponseGeneral(
            code: "01",
            data: -1,
            message: "Your account is not found, please try login again"
          );
        }
      });

      return result;
    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "There's a problem when changing your account password",
        data: -1
      );
    }
  }
}