import 'dart:convert';
import 'dart:io';

import 'package:amazon/constants/error_handler.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
// function for signup
  Future<UserModel?> signupUser(UserModel user, BuildContext context) async {
    var url = Uri.parse("$baseUrl/api/signup");
    try {
      var response = await http.post(
        url,
        body: json.encode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      int num = errorHandler(
          response: response,
          context: context,
          onSuccess: 'account created successfully');
      return num == 200 ? UserModel.fromJson(jsonDecode(response.body)) : null;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  Future<UserModel?> loginUser(
      String email, String password, BuildContext context) async {
    var url = Uri.parse("$baseUrl/api/signin");
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      int num = errorHandler(
          response: response,
          context: context,
          onSuccess: 'logged in succeffully');
      if (num == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        String token = jsonDecode(response.body)['token'];
        saveData(user, token);
        return user;
      }
      return null;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  Future saveData(UserModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    setUser(user);
    await prefs.setString('token', token);
  }

  Future<bool> getUserToken(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');
      print(token);
      if (token == null) prefs.setString('token', '');
      var tokenRes = await http.post(Uri.parse("$baseUrl/isTokenValid"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'token': token!
          });
      bool response = jsonDecode(tokenRes.body);
      print(response);
      return response;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return false;
  }

  Future getUserData(BuildContext context) async {
    try {
      var url = Uri.parse("$baseUrl/");
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token!
      });
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      setUser(user);
    } catch (error) {
      showScaffold(context, error.toString());
    }
  }
}
