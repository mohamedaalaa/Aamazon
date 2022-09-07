import 'dart:convert';

import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

int errorHandler(
    {required http.Response response,
    required BuildContext context,
    required String onSuccess}) {
  switch (response.statusCode) {
    case 400:
      showScaffold(context, jsonDecode(response.body)['msg']);
      return 400;
    case 500:
      showScaffold(context, jsonDecode(response.body)['error']);
      return 500;
    default:
      showScaffold(context, onSuccess);
      return 200;
  }
}
