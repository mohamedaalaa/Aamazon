import 'dart:convert';
import 'dart:io';

import 'package:amazon/constants/error_handler.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  Future<Product?> addProduct(
      String name,
      String description,
      String quantity,
      String price,
      String category,
      List<File> files,
      BuildContext context) async {
    var url = Uri.parse("$baseUrl/admin/add-product");
    List<String> imageUrls = [];
    final cloudinary = CloudinaryPublic('dzdauv7ov', 'qddr0stb');
    for (var file in files) {
      CloudinaryResponse res =
          await cloudinary.uploadFile(CloudinaryFile.fromFile(file.path));
      imageUrls.add(res.secureUrl);
    }
    Product product = Product(
        name: name,
        description: description,
        images: imageUrls,
        quantity: quantity,
        price: price,
        category: category);
    try {
      var response = await http.post(
        url,
        body: product.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
      );
      print(jsonDecode(response.body));
      int num = errorHandler(
          response: response,
          context: context,
          onSuccess: 'product added successfully');
      print(num);
      if (num == 200) {
        Product product = Product.fromMap(jsonDecode(response.body));
        print(product.name);
        return product;
      }
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }

  //fetch all produsts
  Future<List<Product>?> fetchAllProducts(BuildContext context) async {
    var url = Uri.parse("$baseUrl/admin/get-product");

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': getUser.token,
        },
      );
      var products = jsonDecode(response.body);
      List<Product>? allProducts;
      allProducts = List<Product>.from(products.map((x) => Product.fromMap(x)));
      return allProducts;
    } catch (error) {
      showScaffold(context, error.toString());
    }
    return null;
  }
}
