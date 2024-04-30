import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<String>{
  UserCubit():super('no-username');

  void setUser(String user){
    emit(user);
  }

}