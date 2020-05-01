part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  final bool obscureText1, obscureText2;
  RegisterInitial({this.obscureText1, this.obscureText2});
  @override
  List<Object> get props => [obscureText1, obscureText2];
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
  ErrorBlocState({@required this.message});

  @override
  List<Object> get props => [message];

}

//Change password visibility
class ChangeVisibility extends RegisterState {

  final bool obscureText1, obscureText2;
  ChangeVisibility({this.obscureText1, this.obscureText2});

  @override
  List<Object> get props => [obscureText1, obscureText2];

}