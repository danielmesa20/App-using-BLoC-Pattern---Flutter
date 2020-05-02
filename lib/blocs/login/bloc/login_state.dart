part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

//Estado inicial
class LoginInitial extends LoginState {
  final bool showPassword;
  LoginInitial(this.showPassword);

  @override
  List<Object> get props => [showPassword];
}

// Mostrar Loading
class LogginInBlocState extends LoginState {
  @override
  List<Object> get props => [];
}

// Usuario logueado correctamente
class LoggedInBlocState extends LoginState {
  final String token;
  LoggedInBlocState({this.token});

  @override
  List<Object> get props => [token];
}

// Error al Loguear
class ErrorBlocState extends LoginState {
  final String message;
  ErrorBlocState({this.message});

  @override
  List<Object> get props => [message];
}

// State password visibility
class ChangeObscureText extends LoginState {
  final bool showPassword;
  ChangeObscureText({this.showPassword});

  @override
  List<Object> get props => [showPassword];
}
