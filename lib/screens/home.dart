import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_bloc/blocs/home/bloc/home_bloc.dart';
import 'package:login_bloc/screens/addProduct.dart';
import 'package:login_bloc/screens/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("App Test"),
              centerTitle: true,
              actions: <Widget>[
                PopupMenuButton<int>(
                  offset: Offset(0, 100),
                  onSelected: (value) async {
                    await _signOut(context);
                  },
                  itemBuilder: (context) => <PopupMenuEntry<int>>[
                    PopupMenuItem(child: Text('Salir'), value: 0,),
                  ],
                )
              ],
            ),
            body: Center(child: SingleChildScrollView(child: _bodyPage(state.props[0]))),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.blue,
              fixedColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text("Home")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), title: Text("Add")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), title: Text("Ver"))
              ],
              currentIndex: state.props[0],
              onTap: (value) => {
                //Change Screen
                BlocProvider.of<HomeBloc>(context)
                    .add(ChangeScreen(page: value)),
              },
            ),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }

  //Change Page
  Widget _bodyPage(int page) {
    if (page == 1) {
      return AddProductScreen();
    } else if (page == 0) {
      return Center(child: Text("Home"));
    } else {
      return Center(child: Text("List"));
    }
  }

  //SignOut
  Future _signOut(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
