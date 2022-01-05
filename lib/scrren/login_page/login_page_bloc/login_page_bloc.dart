import 'package:cupertione_flutter/scrren/login_page/login_page_service/login_page_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page_event.dart';
import 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LoginPageService loginPageService = LoginPageService();
  LoginPageBloc() : super(InitialLoginState()) {
    on(loginEventControl);
  }

  Future<void> loginEventControl(
      LoginPageEvent event, Emitter<LoginPageState> emit) async {
    if (event is CreateUserLoginPageEvent) {
      emit(LoadingLoginState());
      try {
        final result = await loginPageService.createUser(
            email: event.personModel.mail!,
            password: event.personModel.password!);
        final result2 = await loginPageService.create(
            event.personModel.toMap(), firebaseAuth.currentUser!.uid);
        emit(CreateSuccsesLoginPageState());
      } catch (e) {}
    }
  }
}
