import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_bloc/controllers/LoginLogic.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginLogic logic;
  LoginBloc({@required this.logic});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // Try to Login
    if (event is DoLoginEvent) {
      //Show spinner in UI
      yield LogginInBlocState();
      try {
        var token = await logic.login(event.email, event.password);
        yield LoggedInBlocState(token: token);
      } on InvalidCredentialException {
        yield ErrorBlocState(message: "Las credenciales no son validas");
      } on EmptyCredentialException {
        yield ErrorBlocState(message: "Debe ingresar ambas credenciales");
      } on InvalidFormatEmailException {
        yield ErrorBlocState(
            message: "Debe ingresar un email con un formato valido");
      } on LoginException {
        yield ErrorBlocState();
      }
    } else if (event is ChangeObscureTextEvent) {
      yield ChangeObscureText();
    }
  }
}
