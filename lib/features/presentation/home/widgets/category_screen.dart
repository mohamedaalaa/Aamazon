import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/features/presentation/admin_screen/widgets.dart';
import 'package:amazon/features/presentation/home/cubit/home_cubit.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/features/widgets/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late HomeCubit bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.goPop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          title: Text(widget.category),
          leading: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () => goToPushNamed(homeR, context),
                  icon: const Icon(Icons.arrow_back));
            },
          )),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case GothUserProducts:
              showScaffold(context, "Got user products");
          }
        },
        builder: (context, state) {
          if (state is HomeInitial) {
            bloc.fetchAllProducts(context, widget.category);
          }
          if (state is FetchUserProducts || state is HomeInitial) {
            return const ShowDialog(
                title: 'Loading products',
                actions: [CircularProgressIndicator()]);
          }
          return bloc.userProducts.isEmpty
              ? const Center(child: Text("No products yet please add some"))
              : ProductsView(products: bloc.userProducts);
        },
      ),
    );
  }
}
