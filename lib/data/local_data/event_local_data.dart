

import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/data/local_data/logs_local_data.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/data/models/logs_model.dart';
import 'package:flutter/material.dart';

class EventLocalData {
  final DatabaseConfig _database;
  final LogsLocalData _logsLocalData;

  EventLocalData({
    required DatabaseConfig database,
    required LogsLocalData logsLocalData
  }) : _database = database,
       _logsLocalData = logsLocalData;

  Future<ResponseGeneral<int>> insertAndUpdate({
    required EventModel data
  }) async {
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      //Variable For Logs
      late String actionName;
      late String description;
      final userName = await shared.getString(key: ConstansValue.username);
      final userIdShared = await shared.getInt(key: ConstansValue.user_id);
        data.userId = userIdShared;

      final result = await db.transaction<int>((trx) async{
        final startHourFirstPart = (data.startHour?.hour ?? 0) < 10 ? "0${data.startHour?.hour}" : data.startHour?.hour;
        final startHourSecondPart = (data.startHour?.minute ?? 0) < 10 ? "0${data.startHour?.minute}" : data.startHour?.minute;

        final endHourFirstPart = (data.endHour?.hour ?? 0) < 10 ? "0${data.endHour?.hour}" : data.endHour?.hour;
        final endHourSecondPart = (data.endHour?.minute ?? 0) < 10 ? "0${data.endHour?.minute}" : data.endHour?.minute;

        late int resultInsert;
        if (data.id != 0 && data.id != null){
          final checkData = await trx.query("events", where: 'id = ?', whereArgs: [data.id]);

          if (checkData.isNotEmpty){
            resultInsert = await trx.update("events", {
              "user_id": data.userId,
              "title": data.title,
              "date_of_event": data.dateOfEvent.toString(),
              "start_hour": "$startHourFirstPart:$startHourSecondPart",
              "end_hour": "$endHourFirstPart:$endHourSecondPart",
              "description": data.description,
              "priority": data.priority?.name.toUpperCase(),
              "status": data.status?.name.toUpperCase(),
              "updated_at": DateTime.now().toString()
            }, where: 'id = ?', whereArgs: [data.id]);

            final dataOld = checkData.first;
            actionName = "update";
            description = "$userName update data event id data ${dataOld['id']} and title ${dataOld['title']} at ${DateTime.now().toString()}";
          } else {
            resultInsert = -1;
          }

        } else {
          resultInsert = await trx.insert("events", {
            "user_id": data.userId,
            "title": data.title,
            "date_of_event": data.dateOfEvent.toString(),
            "start_hour": "$startHourFirstPart:$startHourSecondPart",
            "end_hour": "$endHourFirstPart:$endHourSecondPart",
            "description": data.description,
            "priority": data.priority?.name.toUpperCase(),
            "status": data.status?.name.toUpperCase(),
            "created_at": DateTime.now().toString(),
            "updated_at": DateTime.now().toString()
          });

          if (resultInsert >= 1){
            actionName = "create";
            description = "$userName create new data events with title ${data.title} at ${DateTime.now().toString()}";
          }
        }

        return resultInsert;
      });

      if (result >= 1){
        await _logsLocalData.createLogs(data: LogsModel(
          actionName: actionName,
          description: description,
          tableAction: "events",
          updatedAt: DateTime.now(),
          userId: userIdShared,
          createdAt: DateTime.now()
        ));
        return ResponseGeneral(
          code: "00",
          message: "Creating new data event schedule successfully",
          data: result
        );
      } else {
        return ResponseGeneral(
          code: "01",
          message: "Something's wrong when trying to add new data",
          data: -1
        );
      }
    } catch (e){
      print(e);
      return ResponseGeneral(
        code: "01",
        message: "Something's wrong when trying to add new data",
        data: -1
      );
    }
  }

  Future<EventModelResponse> getAllEvent() async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = await db.transaction<List<Map>>((trx) async{
        final userIdShared = await shared.getInt(key: ConstansValue.user_id);
        final query = await trx.query("events", where: 'user_id = ?', whereArgs: [userIdShared]);

        return query;
      });

      if (result.isNotEmpty){
        return EventModelResponse(
          code: "00",
          message: "Get event data success",
          data: result.map<EventModel>((data) {
            return EventModel(
              id: data["id"],
              userId: data["user_id"],
              dateOfEvent: DateTime.parse(data["date_of_event"]),
              title: data["title"],
              description: data["description"],
              startHour: TimeOfDay.fromDateTime(DateTime.parse("0001-01-01 ${data["start_hour"]}")),
              endHour: TimeOfDay.fromDateTime(DateTime.parse("0001-01-01 ${data["end_hour"]}")),
              priority: data["priority"] == "LOW"
                ? PRIORITY.low
                : data["priority"] == "MEDIUM"
                  ? PRIORITY.medium
                  : PRIORITY.high,
              status: data["status"] == "IDLE"
                ? STATUS.idle
                : data["status"] == "PROGRESS"
                  ? STATUS.progress
                  : STATUS.done
            );
          }).toList()
        );
      } else {
        return EventModelResponse(
          code: "00",
          message: "You don't have any data on Events",
          data: []
        );
      }
    } catch (e){
      return EventModelResponse(
        code: "01",
        message: "Something's wrong when trying to add new data",
        data: []
      );
    }
  }

  Future<ResponseGeneral> deleteEvent({
    required EventModel data
  }) async {
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = await db.transaction<int>((trx) async{
        
        final resultQuery = await trx.delete("events", where: 'id = ?', whereArgs: [data.id]);

        return resultQuery;
      });  

      if (result >= 1){
        final userName = await shared.getString(key: ConstansValue.username);
        final userId = await shared.getInt(key: ConstansValue.user_id);

        await _logsLocalData.createLogs(data: LogsModel(
          actionName: "delete",
          description: "$userName deleted data event id data ${data.id} and title ${data.title} at ${DateTime.now()}",
          tableAction: "events",
          updatedAt: DateTime.now(),
          userId: userId,
          createdAt: DateTime.now()
        ));

        return ResponseGeneral(
          code: "00",
          message: "Creating new data event schedule successfully",
          data: result
        );
      } else {
        return ResponseGeneral(
          code: "01",
          message: "Something's wrong when trying to add new data",
          data: -1
        );
      }
    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "Something's wrong when trying to delete data",
        data: -1
      );
    }
  }
}