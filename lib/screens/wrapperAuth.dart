import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_bloc/screens/home.dart';
import 'package:login_bloc/screens/login.dart';
import 'package:login_bloc/shared/loading.dart';

class WrapperAuth extends StatefulWidget {
  @override
  _WrapperAuthState createState() => _WrapperAuthState();
}

class _WrapperAuthState extends State<WrapperAuth> {

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  //Verifica si el usuario ya se logueo en la aplicación
  checkLoginStatus() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String token = await storage.read(key: "token");
    if (token == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}
