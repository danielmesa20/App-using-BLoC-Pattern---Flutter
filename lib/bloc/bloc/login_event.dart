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

class ChangeObscureTextEvent extends LoginEvent {

  final bool obscureText;

  ChangeObscureTextEvent(this.obscureText);

  @override
  List<Object> get props => [obscureText];
}

