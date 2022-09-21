import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/features/presentation/auth/auth_cubit.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/features/widgets/button.dart';
import 'package:amazon/features/widgets/custom_text_field.dart';
import 'package:amazon/features/presentation/home/widgets/carousel.dart';
import 'package:amazon/features/widgets/loading.dart';
import 'package:amazon/models/product.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants/sizes.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final key = GlobalKey<FormState>();

  String dropDownValue = 'mobiles';

  // clearTextField() {
  //   nameController.text = '';
  //   descController.text = '';
  //   priceController.text = '';
  //   quantityController.text = '';
  // }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        final bloc = BlocProvider.of<AdminCubit>(context);
        switch (state.runtimeType) {
          case ProductAdded:
            bloc.imageFiles = [];
            goToPopNamed(context);
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AdminCubit>(context);
        void addProduct() {
          bool isValid = key.currentState!.validate();
          if (bloc.imageFiles.isEmpty) {
            showScaffold(context, 'Pick some photos for your product');
          }
          if (isValid) {
            FocusScope.of(context).unfocus();

            print("here");
            bloc.addProduct(
                nameController.text,
                descController.text,
                quantityController.text,
                priceController.text,
                dropDownValue,
                bloc.imageFiles,
                context);
          }
        }

        return Scaffold(
            appBar: getAppBar(
              title: const Text("Add Product"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: key,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () => bloc.pickImages(context),
                            child: DottedBorder(
                              dashPattern: const [4, 10],
                              strokeCap: StrokeCap.round,
                              radius: const Radius.circular(10),
                              child: SizedBox(
                                width: context.width,
                                height: 150,
                                child: bloc.imageFiles.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.folder_outlined),
                                            gapH10,
                                            Text("Select Product Image")
                                          ],
                                        ),
                                      )
                                    : CarouselFiles(
                                        images: bloc.imageFiles, height: 150),
                              ),
                            )),
                        gapH10,
                        CustomTextField(
                            validator: (value) {
                              if (nameController.text.isEmpty ||
                                  nameController.text.length < 5) {
                                return "name can't be less thn 5";
                              }
                              return null;
                            },
                            controller: nameController,
                            text: 'Product Name'),
                        gapH10,
                        CustomTextField(
                          validator: (value) {
                            if (descController.text.isEmpty ||
                                descController.text.length < 5) {
                              return "description can't be less thn 5";
                            }
                            return null;
                          },
                          controller: descController,
                          text: 'description',
                          lines: 5,
                        ),
                        gapH10,
                        CustomTextField(
                            inputType: TextInputType.number,
                            validator: (value) {
                              if (priceController.text.isEmpty) {
                                return "price can't be empty";
                              }
                              return null;
                            },
                            controller: priceController,
                            text: 'Price \$'),
                        gapH10,
                        CustomTextField(
                            inputType: TextInputType.number,
                            validator: (value) {
                              if (quantityController.text.isEmpty) {
                                return "quantity can't be empty";
                              }
                              return null;
                            },
                            controller: quantityController,
                            text: 'Quantity'),
                        gapH10,
                        DropdownButton(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: dropDownValue,
                            items: bloc.items.map((name) {
                              return DropdownMenuItem(
                                value: name,
                                child: Text(name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            }),
                        gapH30,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              switch (state.runtimeType) {
                                case AddProduct:
                                  return const Loading();
                                default:
                                  return Button(
                                      onPressed: () => addProduct(),
                                      child: const Text("Add Product"));
                              }
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ));
      },
    );
  }
}
