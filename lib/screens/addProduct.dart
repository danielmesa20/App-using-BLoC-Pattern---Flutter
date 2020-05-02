import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  //Variables
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final FocusNode _nodePrice = FocusNode();
  final FocusNode _nodeCategory = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Agrege un producto",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                letterSpacing: 1.5,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: _name,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_nodePrice),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _price,
              focusNode: _nodePrice,
              decoration: InputDecoration(
                labelText: "Precio",
              ),
             onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_nodeCategory),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _category,
              focusNode: _nodeCategory,
              decoration: InputDecoration(
                labelText: "Categoria",
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Enter"),
              onPressed: () {
                //Try to Login Uswer
              },
            ),
          ],
        ),
      ),
    );
  }
}
