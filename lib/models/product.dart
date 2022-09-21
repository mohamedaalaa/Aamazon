// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon/features/widgets/rating_bar.dart';
import 'package:amazon/models/rating.dart';

class Product {
  final String name;
  final String description;
  final List<String> images;
  final String quantity;
  final String price;
  final String category;
  final String id;
  final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.category,
    required this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'images': images,
      'quantity': quantity,
      'price': price,
      'category': category,
      'id': id,
      'rating': rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      description: map['description'],
      images: List<String>.from((map['images'])),
      quantity: map['quantity'],
      price: map['price'],
      category: map['category'],
      id: map['_id'],
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating'].map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(Map<String, String> json) => Product.fromMap(json);
}
