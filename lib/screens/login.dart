import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/blocs/login/bloc/login_bloc.dart';
import 'package:login_bloc/controllers/LoginLogic.dart';
import 'package:login_bloc/screens/home.dart';
import 'package:login_bloc/screens/register.dart';
import 'package:login_bloc/shared/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Variables
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  FocusNode _nodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(logic: SimpleLoginLogic()),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: _listenerMethod,
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: _builderMethod,
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _builderMethod(context, state) {
    if (state is LogginInBlocState) {
      return Loading();
    } else {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40.0,
                        letterSpacing: 1.5,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email", hintText: 'example@example.com'),
                    controller: _emailC,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_nodePassword),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: state.showPassword,
                    controller: _passwordC,
                    focusNode: _nodePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                          icon: state.showPassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            //Change password visibility
                            BlocProvider.of<LoginBloc>(context)
                                .add(ChangeObscureTextEvent());
                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text("Enter"),
                    onPressed: () {
                      //Try to Login Uswer
                      BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(
                          email: _emailC.text, password: _passwordC.text));
                    },
                  ),
                  RaisedButton(
                    child: Text("Aún no tengo una cuenta"),
                    onPressed: () {
                      //Go to Register Screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void _listenerMethod(context, state) {
    if (state is ErrorBlocState) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message, textAlign: TextAlign.center),
        ),
      );
    } else if (state is LoggedInBlocState) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
