
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:college_scheduler/data/models/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginState{}

class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginFailedState extends LoginState{}


class LoginCubit extends Cubit<StateGeneral<LoginState, UsersModel?>>{

  final UsersLocalData _usersLocalData;

  LoginCubit({
    required UsersLocalData usersLocalData,
  }) : _usersLocalData = usersLocalData,
       super(StateGeneral(state: LoginInitialState()));

  StateGeneral<LoginState, UsersModel?> loginState = StateGeneral(state: LoginInitialState());

  Future<void> login({
    required String username,
    required String password
  }) async{
    try {
      loginState = StateGeneral(state: LoginLoadingState());
      emit(loginState);

      final result = await _usersLocalData.login(
        username: username,
        password: password
      );

      if (result.code == "00"){
        loginState = StateGeneral(
          state: LoginSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data?.first
        );
      } else {
        loginState = StateGeneral(
          state: LoginFailedState(),
          code: result.code,
          message: result.message,
          data: null
        );
      }

      emit(loginState);
    } catch (e){
      loginState = StateGeneral(
        state: LoginFailedState(),
        code: "01",
        message: "There's a problem creating your account i am sorry );",
        data: null
      );
      emit(loginState);

    }
  }
}