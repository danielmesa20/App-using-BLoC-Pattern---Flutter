part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}


//Mostrar Loading
class LogginInBlocState extends LoginState {
   @override
  List<Object> get props => [];
}

//Usuario logueado correctamente
class LoggedInBlocState extends LoginState {

  final String token;
  LoggedInBlocState({this.token});

  @override
  List<Object> get props => [token];

}

//Error al Loguear
class ErrorBlocState extends LoginState {

  final String message;
  ErrorBlocState({this.message});

  @override
  List<Object> get props => [message];

}

class ChangeObscureText extends LoginState {
   @override
  List<Object> get props => [];
}

