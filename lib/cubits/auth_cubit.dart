import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(false);

  void login(String username, String password) {
    if (username == 'admin' && password == 'password') {
      emit(true);
    }
  }

  void logout() {
    emit(false);
  }
}
