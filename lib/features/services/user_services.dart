import 'dart:convert';

import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/rating.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserServices {
  //fetch user services
  Future<List<Product>?> fetchAllProducts(
      BuildContext context, String category) async {
    var url = Uri.parse("$baseUrl/api/products?category=$category");
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
      );
      var products = jsonDecode(response.body);
      print(products);
      List<Product>? allProducts;
      allProducts = List<Product>.from(products.map((x) => Product.fromMap(x)));
      return allProducts;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  //search
  Future<List<Product>?> searchProducts(
      BuildContext context, String query) async {
    try {
      var url = Uri.parse("$baseUrl/api/products/search/$query");
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
      );
      var products = jsonDecode(response.body);
      print(products);
      List<Product>? allProducts;
      allProducts = List<Product>.from(products.map((x) => Product.fromMap(x)));
      return allProducts;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  Future<Product?> dealOfTheDay(BuildContext context) async {
    try {
      var url = Uri.parse("$baseUrl/api/deal-of-day");
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
      );
      var result = jsonDecode(response.body);
      Product product = Product.fromMap(result);
      return product;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  //add to cart

}
