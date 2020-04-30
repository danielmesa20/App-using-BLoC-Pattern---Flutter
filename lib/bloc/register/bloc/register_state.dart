part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

//Mostrar Loading
class IsLoadingState extends RegisterState {
   @override
  List<Object> get props => [];
}

//Usuario Registrado correctamente
class RegisteredInBlocState extends RegisterState {

  final String token;
  RegisteredInBlocState({this.token});

  @override
  List<Object> get props => [token];

}

//Error al Registrarse
class ErrorBlocState extends RegisterState {

  final String message;
  ErrorBlocState({this.message});

  @override
  List<Object> get props => [message];

}