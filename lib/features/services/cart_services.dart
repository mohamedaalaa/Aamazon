import 'dart:convert';

import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/global_variables.dart';
import '../../models/user.dart';

class CartServices {
  Future<UserModel?> addToCart(String productId, BuildContext context) async {
    try {
      var url = Uri.parse("$baseUrl/api/add-to-cart");

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
        body: jsonEncode({
          'id': productId,
        }),
      );
      var result = jsonDecode(response.body);
      print(result['cart']);
      setUserCart(cart: result['cart']);
      // print(user.cart.length);
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  Future<UserModel?> addOrRemoveFromCart(
      String productId, BuildContext context) async {
    try {
      var url = Uri.parse("$baseUrl/api/remove-from-cart/$productId");

      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
        body: jsonEncode({
          'id': productId,
        }),
      );
      var result = jsonDecode(response.body);
      setUserCart(cart: result['cart']);
      print(getUser.cart);
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  Future<UserModel?> deleteCart(String productId, BuildContext context) async {
    try {
      var url = Uri.parse("$baseUrl/api/removecart/$productId");

      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
        body: jsonEncode({
          'id': productId,
        }),
      );
      var result = jsonDecode(response.body);
      // setUserCart(cart: result['cart']);
      print(result);
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  Future<Product?> rateProduct({
    required BuildContext context,
    required String id,
    required double rating,
  }) async {
    try {
      var url = Uri.parse("$baseUrl/api/rate-product");
      var response = await http.post(
        url,
        body: jsonEncode({
          'id': id,
          'rating': rating,
        }),
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
      );
      var result = jsonDecode(response.body);
      print(result);
      Product product = Product.fromMap(result);
      if (product.rating!.isNotEmpty) {
        for (var rate in product.rating!) {
          print(rate.rating);
        }
      }
      return product;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }
}
