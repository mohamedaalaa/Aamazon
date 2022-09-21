import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/features/services/user_services.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/rating.dart';
import 'package:amazon/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Product> userProducts = [];
  List<Product> searchResults = [];
  Product? dealofDay;

//navigate back and reset state
  void goPop() async {
    emit(HomeInitial());
  }

//fetch all products
  Future fetchAllProducts(BuildContext context, String category) async {
    try {
      emit(FetchUserProducts());
      var products = await UserServices().fetchAllProducts(context, category);
      if (products != null) {
        userProducts = products;
      } else {
        emit(Error());
      }
    } finally {
      emit(GothUserProducts());
    }
  }

  Future searchProducts(BuildContext context, String query) async {
    try {
      emit(SearchProduct());
      var products = await UserServices().searchProducts(context, query);
      if (products != null) {
        searchResults = products;
      }
    } finally {
      emit(SearchDone());
    }
  }

  Future dealOfTheDay(BuildContext context) async {
    try {
      emit(GetDofd());
      dealofDay = await UserServices().dealOfTheDay(context);
    } finally {
      emit(GotDofd());
    }
  }
}
