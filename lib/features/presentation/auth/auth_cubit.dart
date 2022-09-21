import 'package:amazon/models/user.dart';
import 'package:amazon/features/services/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool isSignin = true;
  bool isAdmin = true;
  var regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool? isTokenValid;

  void toggle() {
    isAdmin = !isAdmin;
    emit(ToggleState());
  }

  void toggleSignin() {
    isSignin = !isSignin;
    emit(ToggleState());
  }

  Future signupUser(UserModel user, BuildContext context) async {
    emit(SigningUser());
    var user1 = await AuthService().signupUser(user, context);
    user1 == null ? emit(AuthError()) : emit(SignedUser());
  }

  Future loginUser(String email, String password, BuildContext context) async {
    emit(LogingUser());
    var user = await AuthService().loginUser(email, password, context);
    user == null ? emit(AuthError()) : emit(LogedUser());
  }

  Future<bool> getUserToken(BuildContext context) async {
    try {
      emit(GettingToken());
      bool isTokenValid = await AuthService().getUserToken(context);
      print(isTokenValid);
      return isTokenValid;
    } finally {
      emit(GotToken());
    }
  }
}
