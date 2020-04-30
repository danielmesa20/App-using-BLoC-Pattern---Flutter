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

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
     // Try to Register
    if (event is DoRegisterEvent){
      yield IsLoadingState();
      try{
        var token = await logic.register(event.email, event.password, event.password2, event.username);
        yield RegisteredInBlocState(token: token);
      } on DontMatchPasswordException{
        yield ErrorBlocState(message: "Las contraseñas no son iguales");
      } on EmptyCredentialException {
        yield ErrorBlocState(message: "Debe ingresar todas credenciales");
      } on InvalidFormatEmailException {
        yield ErrorBlocState(message: "Debe ingresar un email con un formato valido");
      } on WeakPasswordException {
        yield ErrorBlocState(message: "La contraseña de 6 o mas caracteres");
      } on RegisterException {
        yield ErrorBlocState(message: "Ese email ya se encuentra registrado");
      } 
    }
  }
}
