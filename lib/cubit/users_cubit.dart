
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserState{}

class UserInitState extends UserState{}
class UserLoadingState extends UserState{}
class UserLoadedState extends UserState{}
class UserFailedState extends UserState{
  String? message;

  UserFailedState({
    this.message
  });
}


class UsersCubit extends Cubit<UserState>{

  final UsersLocalData _usersLocalData;

  UsersCubit({
    required UsersLocalData usersLocalData,
  }) : _usersLocalData = usersLocalData,
       super(UserInitState());


  UserState getAllDataState = UserInitState();
  Future<void> getAllData() async{
    try {
      getAllDataState = UserLoadingState();
      emit(getAllDataState);

      final result = await _usersLocalData.getAllData();
      getAllDataState = UserLoadedState();
      emit(getAllDataState);
    } catch (e){
      getAllDataState = UserFailedState(
        message: e.toString()
      );
      emit(getAllDataState);
    }
  }

  UserState registerState = UserInitState();
  Future<void> registerAccount({
    required String fullname,
    required String username,
    required String password
  }) async{
    try {
      registerState = UserLoadingState();
      emit(registerState);

      await _usersLocalData.registerAccount(fullname: fullname, username: username, password: password);
      registerState = UserLoadedState();
      emit(registerState);
    } catch (e){
      registerState = UserFailedState(
        message: e.toString()
      );
      emit(registerState);
    }
  }
}