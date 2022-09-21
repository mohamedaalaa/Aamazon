import 'dart:convert';

import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  Future saveUserAddress(BuildContext context, String address) async {
    try {
      var url = Uri.parse("$baseUrl/api/save-user-address");
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'token': getUser.token,
          },
          body: jsonEncode({'address': address}));

      print(jsonDecode(response.body));
    } catch (error) {
      showScaffold(context, error.toString());
    }
  }
}
