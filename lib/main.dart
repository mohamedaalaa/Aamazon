import 'package:amazon/constants/bottom_bar.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/admin_screen.dart';
import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/features/presentation/cart_screen/cubit/cart_cubit.dart';
import 'package:amazon/features/presentation/home/cubit/home_cubit.dart';
// import 'package:amazon/features/presentation/search/cubit/cubit/product_cubit.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/features/presentation/auth/signup/signup.dart';
import 'package:amazon/features/presentation/home/home.dart';
import 'package:amazon/features/services/auth_service.dart';
import 'package:amazon/features/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/auth/auth_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  late bool isTokenValid;
  @override
  void initState() {
    AuthService().getUserToken(context).then((value) {
      if (value) {
        print('value = $value');
        AuthService().getUserData(context).then((value) {
          isLoading = false;
          setState(() {});
        });
      } else {
        isLoading = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => HomeCubit()..dealOfTheDay(context)),
        BlocProvider(
            create: (context) => AdminCubit()..fetchAllProducts(context)),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amazon',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          ),
          onGenerateRoute: generateRout,
          home: isLoading
              ? const LoadingUser()
              : getUser.token.isEmpty
                  ? const Signup()
                  : getUser.type == "admin"
                      ? const AdminScreen()
                      : const BottomBar()),
    );
  }
}
