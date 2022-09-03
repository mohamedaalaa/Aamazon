import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: context.width,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Center(
          child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          gapW4,
          Expanded(
            child: Text(
              "deliver to ${getUser.name}, ${getUser.address}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_drop_down)),
          )
        ],
      )),
      // color: GlobalVariables.appBarGradient,
    );
  }
}
