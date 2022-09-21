import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/widgets.dart';
import 'package:amazon/features/presentation/home/cubit/home_cubit.dart';
import 'package:amazon/features/presentation/search/search_results.dart';
import 'package:amazon/features/services/user_services.dart';
import 'package:amazon/features/widgets/product_details.dart';
import 'package:amazon/features/widgets/rating_bar.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchScreen extends SearchDelegate {
  List<Product> products = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => goToPopNamed(context),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? const Center(child: Text("type to search"))
        : FutureBuilder(
            future: UserServices().searchProducts(context, query),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text("no products found with this name");
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  print(snapshot.data);
                  products = snapshot.data as List<Product>;

                  return products.isEmpty
                      ? const Center(
                          child: Text("no products found with this name"),
                        )
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  query = products[index].name;
                                  products = [products[index]];
                                  showResults(context);
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(products[index].images[0]),
                                ),
                                title: Text(products[index].name),
                              ),
                            );
                          },
                        );
              }
            },
          );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(pDetailsR, arguments: products[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: context.width * .3,
                      height: 200,
                      child: Image.network(
                          fit: BoxFit.cover, products[index].images[0]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Text(products[index].name),
                        gapH4,
                        Text(
                          products[index].description,
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold),
                        ),
                        gapH4,
                        AddRating(
                          rate: 3,
                          onRatingUpdate: (rate) {},
                        ),
                        Text(
                          "${products[index].price} \$",
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
