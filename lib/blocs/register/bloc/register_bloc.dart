import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_bloc/controllers/RegisterLogic.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterLogic logic;
  RegisterBloc({@required this.logic});

  bool obscureText1 = true;
  bool obscureText2 = true;

  @override
  RegisterState get initialState =>
      RegisterInitial(obscureText1: obscureText1, obscureText2: obscureText2);

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // Try to Register
    if (event is DoRegisterEvent) {
      yield IsLoadingState();
      try {
        var token = await logic.register(
            event.email, event.password, event.password2, event.username);
        yield RegisteredInBlocState(token: token);
      } on UseEmailException {
        yield ErrorBlocState(message: "El email ingresado ya está registrado");
      } on DontMatchPasswordException {
        yield ErrorBlocState(message: "Las contraseñas no son iguales");
      } on EmptyCredentialException {
        yield ErrorBlocState(message: "Debe ingresar todas credenciales");
      } on InvalidFormatEmailException {
        yield ErrorBlocState(
            message: "Debe ingresar un email con un formato valido");
      } on WeakPasswordException {
        yield ErrorBlocState(message: "La contraseña es muy corta (6>)");
      } on RegisterException {
        yield ErrorBlocState(message: "Error al intentar registrar");
      }
       yield ChangeVisibility(
          obscureText1: obscureText1, obscureText2: obscureText2);
          
    } else if (event is ChangedPasswordVisibilityEvent) {
      if (event.textFormField == 0) {
        obscureText1 = !obscureText1;
      } else {
        obscureText2 = !obscureText2;
      }
      yield ChangeVisibility(
          obscureText1: obscureText1, obscureText2: obscureText2);
    }
  }
}
