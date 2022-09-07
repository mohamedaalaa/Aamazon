import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/features/services/admin_services.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/features/widgets/loading.dart';
import 'package:amazon/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              amazonLogo,
              width: 70,
              height: 70,
            ),
            // BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
            //   final bloc = BlocProvider.of<AdminCubit>(context);
            //   return DropdownButton(
            //       icon: const Icon(Icons.keyboard_arrow_down),
            //       value: bloc.dropDownValue,
            //       items: bloc.items.map((name) {
            //         return DropdownMenuItem(
            //           value: name,
            //           child: GestureDetector(
            //             onTap: () => bloc.filterList(name),
            //             child: Text(name),
            //           ),
            //         );
            //       }).toList(),
            //       onChanged: (String? newValue) {
            //         bloc.dropDownValue = newValue!;
            //       });
            // }
            // ),
          ],
        ),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<AdminCubit>(context);
          switch (state.runtimeType) {
            case ProductAdded:
              bloc.fetchAllProducts(context);
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<AdminCubit>(context);
          if (state is GotProducts || state is FilterList) {
            return bloc.showen.isEmpty
                ? const Center(child: Text("No products yet please add some"))
                : GridView.builder(
                    itemCount: bloc.showen.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return MyProduct(product: bloc.showen[index]);
                    },
                  );
          } else {
            return const Center(
              child: Loading(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToNamed(addProductR, context),
        tooltip: "Add a product",
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyProduct extends StatelessWidget {
  final Product product;
  const MyProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: context.width * .5,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: product.images[0],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          gapH4,
          Text(product.name),
          gapH4,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Price: ${product.price}\$"),
              Text("Quantity: ${product.quantity}"),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: () => showMyDialog(
                    isBarier: true,
                    context: context,
                    title: "Delete product",
                    alert1: "Delete product",
                    alert2: "Are you sure?",
                    onPressed: null),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          )
        ],
      ),
    );
  }
}
