import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/bloc/login_bloc.dart';
import 'package:login_bloc/controllers/LoginLogic.dart';
import 'package:login_bloc/screens/home.dart';
import 'package:login_bloc/screens/register.dart';
import 'package:login_bloc/shared/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Input text controllers
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

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
    return state is LogginInBlocState
        ? Loading()
        : Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text("Enter"),
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                  ),
                  RaisedButton(
                    child: Text("Aún no tengo una cuenta"),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => RegisterScreen()));
                    },
                  )
                ],
              ),
            ),
          );
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
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }
  }
}
