import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/services/address_services.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/features/widgets/custom_text_field.dart';
import 'package:amazon/features/widgets/elevated_button.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pay/pay.dart';

class Address extends StatefulWidget {
  final String totalAmount;
  const Address({super.key, required this.totalAmount});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  void initState() {
    super.initState();
  }

  final houseController = TextEditingController();

  final street = TextEditingController();

  final pincode = TextEditingController();

  final townCity = TextEditingController();

  final key = GlobalKey<FormState>();

  payPressed() {
    String address = getUser.address.isNotEmpty
        ? getUser.address
        : "${street.text} ${townCity.text}";
    bool isValid = key.currentState!.validate();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: Text("Address")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: context.width,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(getUser.address.isEmpty
                    ? "No address found"
                    : getUser.address),
              ),
              const Text("OR"),
              CustomTextField(
                controller: houseController,
                text: "House no",
                validator: (p0) {
                  if (houseController.text.isEmpty) {
                    return "house no can't be empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: street,
                text: "Address, street",
                validator: (p0) {
                  if (street.text.isEmpty) {
                    return "Address no can't be empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: pincode,
                inputType: TextInputType.number,
                text: "Pincode",
                validator: (p0) {
                  if (houseController.text.isEmpty) {
                    return "Pincode no can't be empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: townCity,
                text: "House no",
                validator: (p0) {
                  if (townCity.text.isEmpty) {
                    return "town city can't be empty";
                  }
                  return null;
                },
              ),
              gapH10,
              Ebutton(
                  color: Colors.teal,
                  onPressed: () {
                    if (getUser.address.isEmpty) {
                      bool isValid = key.currentState!.validate();
                      if (isValid) {
                        AddressServices().saveUserAddress(
                            context, "${street.text} ${townCity.text}");
                        showBottomSheet(context);
                      }
                    } else {
                      showBottomSheet(context);
                    }
                  },
                  title: "Buy",
                  width: context.width)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: [
          Text("price = ${widget.totalAmount} \$"),
          Text(getUser.address)
        ],
      ),
    );
  }
}
