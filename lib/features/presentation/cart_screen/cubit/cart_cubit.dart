import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/rating.dart';
import 'package:amazon/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../services/cart_services.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  // bool isDetailed = false; //to show cart details in cart screen
  // int selectedIndex = 0;

  Future addToCart({required String id, required BuildContext context}) async {
    try {
      emit(AddOrRemoveFromCart());
      await CartServices().addToCart(id, context);
    } finally {
      emit(AddedOrRemovedFromCart());
    }
  }

  // var cart = getUser.cart;
  List<bool> indexes = List.generate(getUser.cart.length, (index) => false);

  void showQuantityDetails(int index) {
    indexes[index] = !indexes[index];
    emit(IsDetailed());
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var cart in getUser.cart) {
      totalPrice +=
          (cart['quantity'] * int.parse(cart['product']['price'])) as int;
    }
    print(totalPrice);
    return totalPrice;
  }

  Future deleteCart(String productId, BuildContext context) async {
    try {
      emit(DeleteCart());
      await CartServices().deleteCart(productId, context);
    } finally {
      emit(CartDeleted());
    }
  }

  Future addOrDeleteProductFromCart(
      String productId, BuildContext context) async {
    try {
      emit(AddOrRemoveFromCart());
      await CartServices().addOrRemoveFromCart(productId, context);
    } finally {
      emit(AddedOrRemovedFromCart());
    }
  }

  double getProductRate(List<Rating> rating) {
    for (var rate in rating) {
      if (rate.userId == getUser.id) {
        print("current rate=${rate.rating}");
        return rate.rating;
      }
      break;
    }
    return 1;
  }

  Future rateProduct(
      BuildContext context, Product product, double rating) async {
    try {
      emit(RateProduct());
      await CartServices()
          .rateProduct(context: context, id: product.id, rating: rating);
    } finally {
      emit(RateDone());
    }
  }
}
