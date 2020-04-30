import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_bloc/screens/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          PopupMenuButton<int>(
            offset: Offset(0, 100),
            onSelected: (value) async {
              await _signOut(context);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: Text('Salir'),
                value: 1,
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Text("Bienvenido"),
      ),
    );
  }

  Future _signOut(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginScreen()));
  }
}
