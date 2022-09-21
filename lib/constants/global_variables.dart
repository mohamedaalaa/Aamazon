import 'dart:io';

import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/models/user.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

String baseUrl = "https://35e3-197-63-83-79.eu.ngrok.io";

//images path
const String amazonLogo = 'assets/images/amazon_in.png';
const String appliances = 'assets/images/appliances.jpeg';
const String books = 'assets/images/books.jpeg';
const String electronics = 'assets/images/electronics.jpeg';
const String essentials = 'assets/images/essentials.jpeg';
const String fashion = 'assets/images/fashion.jpeg';
const String mobiles = 'assets/images/mobiles.jpeg';

// String getImage(String name) => 'assets/images/$name';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan;
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}

class LoadingUser extends StatelessWidget {
  const LoadingUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            amazonLogo,
            fit: BoxFit.cover,
          ),
          gapH4,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Loading...",
                style: TextStyle(fontSize: 20),
              ),
              gapW10,
              CircularProgressIndicator(
                value: 2,
              )
            ],
          )
        ],
      ),
    );
  }
}

InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
  );
}

void showScaffold(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void goToPushNamed(String route, BuildContext context) =>
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);

void goToNamed(String route, BuildContext context) =>
    Navigator.of(context).pushNamed(
      route,
    );

void goToArgumentsNamed(String route, BuildContext context, String category) =>
    Navigator.of(context).pushNamed(route, arguments: category);

void goToPopNamed(BuildContext context) => Navigator.of(context).pop();

Future<List<File>?> pickMultiImages(BuildContext context) async {
  try {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result == null) return null;

    List<File> files = result.paths.map((path) => File(path!)).toList();
    return files;
  } catch (error) {
    showScaffold(context, error.toString());
  }
  return null;
}

Future<void> showMyDialog({
  required BuildContext context,
  bool isBarier = false,
  required String title,
  required String alert1,
  required String alert2,
  required String id,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: isBarier, // user must ap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(alert1),
              Text(alert2),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => goToPopNamed(context),
              child: const Text("Cancel")),
          BlocBuilder<AdminCubit, AdminState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<AdminCubit>(context);
              switch (state.runtimeType) {
                case DeleteProduct:
                  return const CircularProgressIndicator();
                default:
                  return ElevatedButton(
                    onPressed: () {
                      bloc.deleteProduct(context, id);
                    },
                    child: const Text("Delete"),
                  );
              }
            },
          ),
        ],
      );
    },
  );
}
