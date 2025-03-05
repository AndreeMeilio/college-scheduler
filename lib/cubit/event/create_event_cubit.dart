
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef EventStateType = StateGeneral<CreateEventState, int>;

class CreateEventState {}
class CreateEventInitialState extends CreateEventState{}
class CreateEventLoadingState extends CreateEventState{}
class CreateEventSuccessState extends CreateEventState{}
class CreateEventFailedState extends CreateEventState{}

class CreateEventCubit extends Cubit<EventStateType>{
  final EventLocalData _eventLocalData;

  CreateEventCubit({
    required EventLocalData eventLocalData
  }) : _eventLocalData = eventLocalData,
       super(StateGeneral(state: CreateEventInitialState()));

  EventStateType eventState = EventStateType(state: CreateEventInitialState());
  Future<void> insertEvent({
    required DateTime dateOfEvent,
    required String title,
    required TimeOfDay startHour,
    TimeOfDay? endHour,
    String? description,
    PRIORITY? priority,
    STATUS? status
  }) async{
    try {
      eventState = EventStateType(state: CreateEventLoadingState());
      emit(eventState);
  
      final modelRequest = EventModel(
        title: title,
        dateOfEvent: dateOfEvent,
        startHour: startHour,
        endHour: endHour,
        description: description,
        priority: priority,
        status: status
      );
      final result = await _eventLocalData.insert(data: modelRequest);

      if (result.code == "00"){
        eventState = EventStateType(
          state: CreateEventSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
        emit(eventState);
      } else {
        eventState = EventStateType(
          state: CreateEventFailedState(),
          code: result.code,
          message: result.message,
          data: -1
        );
        emit(eventState);
      }

    } catch (e){
      print(e);
      eventState = EventStateType(
        state: CreateEventFailedState(),
        code: "01",
        message: "There's a problem creating new event i am sorry );",
        data: -1
      );
      emit(eventState);
    }
  }
}