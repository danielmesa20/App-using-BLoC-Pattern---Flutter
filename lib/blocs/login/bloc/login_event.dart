part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

//Evento Login
class DoLoginEvent extends LoginEvent {
  
  final String email, password;

  DoLoginEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

//Change visibility password
class ChangeObscureTextEvent extends LoginEvent {

  ChangeObscureTextEvent();

  @override
  List<Object> get props => [];
}

