import 'package:email_validator/email_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class LoginLogic {
  Future<String> login(String email, String password);
  Future<String> logout();
}

class LoginException implements Exception {}

class EmptyCredentialException implements Exception {}

class InvalidCredentialException implements Exception {}

class InvalidFormatEmailException implements Exception {}

class SimpleLoginLogic extends LoginLogic {
  @override
  Future<String> login(String email, String password) async {
    //Validate empty Inputs
    if (email.isNotEmpty && password.isNotEmpty) {
      //VAlidate Format email
      if (EmailValidator.validate(email)) {
        //Data to Api
        Map data = {'email': email, 'password': password};
        //Url Api to SignIn
        String url = "http://192.168.250.6:3000/auth/signin";
        var response = await http.post(url, body: data);
        var jsonResponse = jsonDecode(response.body);
        //If SignIn is correct
        if (jsonResponse["token"] != null) {
          final storage = new FlutterSecureStorage();
          //Storage Token Auth
          await storage.write(key: "token", value: jsonResponse["token"]);
          return jsonResponse["token"];
        } else {
          throw InvalidCredentialException();
        }
      } else {
        throw InvalidFormatEmailException();
      }
    } else {
      throw EmptyCredentialException();
    }
  }

  @override
  Future<String> logout() async {
    return "";
  }
}
