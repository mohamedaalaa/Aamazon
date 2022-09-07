import 'dart:io';

import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/services/admin_services.dart';
import 'package:amazon/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../constants/sizes.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  List<String> items = [
    'mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  String dropDownValue = "All";

  List<File> imageFiles = [];
  List<Product> products = [];
  List<Product> showen = [];

  void filterList(String? key) {
    key != null
        ? showen = products.where((product) => product.category == key).toList()
        : showen = products;
    emit(FilterList());
  }

  Future pickImages(BuildContext context) async {
    var images = await pickMultiImages(context);
    if (images == null) return;
    imageFiles = images;

    emit(PhotoTaken());
  }

  Future addProduct(name, description, quantity, price, category, files,
      BuildContext context) async {
    // product1 == null ? emit(ProductError()) : emit(ProductAdded());
    try {
      emit(AddProduct());
      Product? product1 = await AdminServices().addProduct(
          name, description, quantity, price, category, files, context);
    } finally {
      emit(ProductAdded());
    }
  }

  Future fetchAllProducts(BuildContext context) async {
    try {
      emit(FetchingProducts());
      List<Product>? allProducts =
          await AdminServices().fetchAllProducts(context);
      if (allProducts != null) {
        products = allProducts;
        showen = allProducts;
      }
    } finally {
      emit(GotProducts());
    }
  }
}
