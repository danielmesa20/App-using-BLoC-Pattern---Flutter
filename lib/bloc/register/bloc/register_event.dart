part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class DoRegisterEvent extends RegisterEvent {
  
  final String email, password, password2, username;

  DoRegisterEvent({this.email, this.password, this.password2, this.username});

  @override
  List<Object> get props => [email, password, password2, username];
}