import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/blocs/register/bloc/register_bloc.dart';
import 'package:login_bloc/controllers/RegisterLogic.dart';
import 'package:login_bloc/screens/login.dart';
import 'package:login_bloc/shared/loading.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Variables
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _password2C = TextEditingController();
  TextEditingController _usernameC = TextEditingController();
  FocusNode _nodeP = FocusNode();
  FocusNode _nodeP2 = FocusNode();
  FocusNode _nodeN = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(logic: SimpleRegisterLogic()),
      child: Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: _listenerMethod,
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: _builderMethod,
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _builderMethod(context, state) {
    return state is IsLoadingState
        ? Loading()
        : Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Registro",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40.0,
                        letterSpacing: 1.5,
                        color: Colors.blueGrey),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: 'example@example.com',
                    ),
                    controller: _emailC,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) =>
                        FocusScope.of(context).requestFocus(_nodeN),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _nodeN,
                    decoration: InputDecoration(labelText: "Username"),
                    controller: _usernameC,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) =>
                        FocusScope.of(context).requestFocus(_nodeP),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _nodeP,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                            icon: state.obscureText1
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              BlocProvider.of<RegisterBloc>(context).add(
                                  ChangedPasswordVisibilityEvent(
                                      textFormField: 0));
                            })),
                    obscureText: state.obscureText1,
                    controller: _passwordC,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) =>
                        FocusScope.of(context).requestFocus(_nodeP2),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _nodeP2,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                            icon: state.obscureText2
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              BlocProvider.of<RegisterBloc>(context).add(
                                  ChangedPasswordVisibilityEvent(
                                      textFormField: 1));
                            })),
                    obscureText: state.obscureText2,
                    controller: _password2C,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text("Enter"),
                    onPressed: () {
                      //Try to Register User
                      BlocProvider.of<RegisterBloc>(context).add(
                          DoRegisterEvent(
                              email: _emailC.text,
                              password: _passwordC.text,
                              password2: _password2C.text,
                              username: _usernameC.text));
                    },
                  ),
                  RaisedButton(
                    child: Text("Ya tengo una cuenta"),
                    onPressed: () {
                      //Go to Login Screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  )
                ],
              ),
            ),
          );
  }

  void _listenerMethod(context, state) {
    if (state is ErrorBlocState) {
      // Mostrar errores
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message, textAlign: TextAlign.center),
        ),
      );
    } else if (state is RegisteredInBlocState) {
      // Ir a la pantalla de login
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
  }
}
