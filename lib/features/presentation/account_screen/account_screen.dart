import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/orders/orders.dart';
import 'package:amazon/features/widgets/blow_app_bar.dart';
import 'package:amazon/features/widgets/button.dart';
import 'package:amazon/features/widgets/account_widgets/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Image.asset(
            amazonLogo,
            width: 70,
            height: 70,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                gapW4,
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            )
          ],
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: Column(
        children: const [
          BlowAppBar(),
          gapH10,
          TopButtons(),
          gapH10,
          Orders(),
        ],
      ),
    );
  }
}
