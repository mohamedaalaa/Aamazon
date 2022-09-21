import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/features/presentation/admin_screen/widgets.dart';
import 'package:amazon/features/services/admin_services.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/features/widgets/loading.dart';
import 'package:amazon/features/widgets/products_view.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({
    super.key,
  });

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
            if (getUser.type == "admin")
              BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {
                  final bloc = BlocProvider.of<AdminCubit>(context);
                  return DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      value: bloc.dropDownValue,
                      items: bloc.items1.map((name) {
                        return DropdownMenuItem(
                          value: name,
                          onTap: () => bloc.filterList(name),
                          child: Text(name),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        bloc.dropDownValue = newValue!;
                      });
                },
              )
          ],
        ),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<AdminCubit>(context);
          switch (state.runtimeType) {
            case ProductAdded:
              bloc.fetchAllProducts(context);
              break;
            case ProductDeleted:
              goToPopNamed(context);
              showScaffold(context, "Product deleted successfully");
              bloc.fetchAllProducts(context);
              break;
            case GotProducts:
              showScaffold(context, "Products loaded successfully");
              break;
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<AdminCubit>(context);
          switch (state.runtimeType) {
            case FetchingProducts:
              return const ShowDialog(
                  title: 'Loading products',
                  actions: [CircularProgressIndicator()]);

            default:
              return bloc.showen.isEmpty
                  ? const Center(child: Text("No products yet please add some"))
                  : ProductsView(
                      products: bloc.showen,
                    );
          }
        },
      ),
      floatingActionButton: getUser.type == "admin"
          ? FloatingActionButton(
              onPressed: () => goToNamed(addProductR, context),
              tooltip: "Add a product",
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
