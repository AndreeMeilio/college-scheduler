
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/class_local_data.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDataClassState {}
class CreateDataClassInitialState extends CreateDataClassState {}
class CreateDataClassSuccessState extends CreateDataClassState {}
class CreateDataClassFailedState extends CreateDataClassState {}
class CreateDataClassLoadingState extends CreateDataClassState {}

typedef CreateDataClassStateType = StateGeneral<CreateDataClassState, int>;

class CreateDataClassCubit extends Cubit<CreateDataClassStateType>{
  final ClassLocalData _classLocalData;

  CreateDataClassCubit({
    required ClassLocalData classLocalData
  }) : _classLocalData = classLocalData,
       super(CreateDataClassStateType(state: CreateDataClassInitialState()));

  CreateDataClassStateType createState = CreateDataClassStateType(state: CreateDataClassInitialState());
  Future<void> createClass({
    required String name,
    required DAYOFWEEK dayofweek,
    required TimeOfDay startHour,
    TimeOfDay? endHour,
    String? lecturerName,
    bool? isEdit,
    int? idClass
  }) async{
    try {
      createState = CreateDataClassStateType(state: CreateDataClassLoadingState());

      final dataRequest = ClassModel(
        name: name,
        lecturerName: lecturerName,
        startHour: startHour,
        endHour: endHour,
        day: dayofweek,
      );

      late ResponseGeneral<int> result;

      if ((isEdit ?? false) && idClass != null){
        dataRequest.id = idClass;

        result = await _classLocalData.createClass(data: dataRequest);
      } else {
        result = await _classLocalData.createClass(data: dataRequest);
      }

      if (result.code == "00"){
        createState = CreateDataClassStateType(
          state: CreateDataClassSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        createState = CreateDataClassStateType(
          state: CreateDataClassFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(createState);
    } catch (e){
      createState = CreateDataClassStateType(
        state: CreateDataClassFailedState(),
        code: "01",
        message: "There's something wrong when creating data class",
        data: -1
      );
      emit(createState);
    }   
  }
}