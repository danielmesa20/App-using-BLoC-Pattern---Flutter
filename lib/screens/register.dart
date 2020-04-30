import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/bloc/register/bloc/register_bloc.dart';
import 'package:login_bloc/controllers/RegisterLogic.dart';
import 'package:login_bloc/screens/login.dart';
import 'package:login_bloc/shared/loading.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Input text controllers
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _password2Controller;
  TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _password2Controller = TextEditingController();
    _usernameController = TextEditingController();
  }

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
                            decoration: InputDecoration(labelText: "Email"),
                            controller: _emailController,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: "Username"),
                            controller: _usernameController,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              obscureText: true,
                              controller: _passwordController),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Confirm Password"),
                            obscureText: true,
                            controller: _password2Controller,
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            child: Text("Enter"),
                            onPressed: () {
                              BlocProvider.of<RegisterBloc>(context).add(
                                  DoRegisterEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      password2: _password2Controller.text,
                                      username: _usernameController.text));
                            },
                          ),
                          RaisedButton(
                            child: Text("Ya tengo una cuenta"),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen()));
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
          }
        }
}
