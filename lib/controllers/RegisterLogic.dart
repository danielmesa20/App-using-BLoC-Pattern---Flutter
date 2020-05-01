import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RegisterLogic {
  Future<String> register(
      String email, String password, String password2, String username);
}

class RegisterException implements Exception {}

class EmptyCredentialException implements Exception {}

class DontMatchPasswordException implements Exception {}

class InvalidFormatEmailException implements Exception {}

class UseEmailException implements Exception {}

class WeakPasswordException implements Exception {}

class SimpleRegisterLogic extends RegisterLogic {
  @override
  Future<String> register(
      String email, String password, String password2, String username) async {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        password2.isNotEmpty &&
        username.isNotEmpty) {
      if (EmailValidator.validate(email)) {
        if (password == password2) {
          if (password.length >= 6) {
            Map data = {
              'email': email,
              'password': password,
              'username': username
            };
            String url = "http://192.168.250.6:3000/auth/signup";
            var response = await http.post(url, body: data);
            var jsonResponse = jsonDecode(response.body);
            if (jsonResponse["token"] != null) {
              return jsonResponse["token"];
            } else if(jsonResponse["err"] == 'Email ya registrado'){
              throw UseEmailException();
            }else {
              throw RegisterException();
            }
          } else {
            throw WeakPasswordException();
          }
        } else {
          throw DontMatchPasswordException();
        }
      } else {
        throw InvalidFormatEmailException();
      }
    } else {
      throw EmptyCredentialException();
    }
  }
}
