import 'package:amazon/constants/bottom_bar.dart';
import 'package:amazon/features/presentation/admin_screen/add_product.dart';
import 'package:amazon/features/presentation/auth/login/login.dart';
import 'package:amazon/features/presentation/cart_screen/address_screen.dart';
import 'package:amazon/features/presentation/home/home.dart';
import 'package:amazon/features/presentation/home/widgets/category_screen.dart';
import 'package:amazon/features/widgets/product_details.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/presentation/auth/signup/signup.dart';

const String loginR = 'login';
const String signupR = 'signup';
const String homeR = 'home';
const String navR = 'nav';
const String addProductR = 'apr';
const String categoryR = 'cr';
const String pDetailsR = 'pd';
const String addressR = 'ar';
const String gpay = 'gpay.json';

Route<dynamic> generateRout(RouteSettings settings) {
  switch (settings.name) {
    case loginR:
      return MaterialPageRoute(builder: (_) => Login());
    case signupR:
      return MaterialPageRoute(builder: (_) => const Signup());
    case navR:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case addProductR:
      return MaterialPageRoute(builder: (_) => const AddProduct());
    case homeR:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case addressR:
      var totalAmount = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => Address(totalAmount: totalAmount,));
    case categoryR:
      var category = settings.arguments as String;
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => CategoryScreen(category: category));
    case pDetailsR:
      var product = settings.arguments as Product;
      return MaterialPageRoute(
          settings: settings, builder: (_) => ProductDetails(product: product));
    default:
      return MaterialPageRoute(builder: (_) => const ErrorWidget());
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Error Widget"),
    );
  }
}
