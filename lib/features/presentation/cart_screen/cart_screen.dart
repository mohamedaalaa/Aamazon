import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/cart_screen/cubit/cart_cubit.dart';
import 'package:amazon/features/presentation/home/cubit/home_cubit.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = BlocProvider.of<CartCubit>(context);
        return Scaffold(
          appBar: getAppBar(title: const Text("Cart")),
          body: getUser.cart.isEmpty
              ? const Center(
                  child: Text("you haven't added any product to the cart"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total Price = ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          gapW4,
                          Text('${bloc.calculateTotalPrice()} \$',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: getUser.cart.length,
                          itemBuilder: (context, index) {
                            var product = getUser.cart[index]['product'];
                            int quantity = getUser.cart[index]['quantity'];
                            var price = int.parse(product['price']) * quantity;
                            return BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                final bloc =
                                    BlocProvider.of<CartCubit>(context);
                                return Card(
                                  child: Column(
                                    children: [
                                      Card(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    product['images'][0]),
                                              ),
                                              title: Text(product['name']),
                                              subtitle:
                                                  Text("total price = $price"),
                                              trailing: Badge(
                                                elevation: 0,
                                                badgeContent: Text(
                                                  '$quantity',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                badgeColor: Colors.blueAccent,
                                                child: const Icon(
                                                  Icons.shopping_cart_outlined,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () => bloc
                                                              .addOrDeleteProductFromCart(
                                                                  getUser.cart[
                                                                              index]
                                                                          [
                                                                          'product']
                                                                      ['_id'],
                                                                  context),
                                                          icon: const Icon(
                                                              Icons.remove)),
                                                      if (state
                                                          is AddOrRemoveFromCart)
                                                        const CircularProgressIndicator()
                                                      else
                                                        Text('$quantity'),
                                                      IconButton(
                                                          onPressed: () => bloc.addToCart(
                                                              id: getUser.cart[
                                                                          index]
                                                                      [
                                                                      'product']
                                                                  ['_id'],
                                                              context: context),
                                                          icon: const Icon(
                                                              Icons.add)),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () => bloc
                                                        .showQuantityDetails(
                                                            index),
                                                    icon: Icon(bloc
                                                            .indexes[index]
                                                        ? Icons.expand_less
                                                        : Icons.expand_more))
                                              ],
                                            ),
                                            if (bloc.indexes[index])
                                              ShowQuantityDetaild(
                                                quantity: quantity,
                                                product: product,
                                                price: price,
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()=> goToArgumentsNamed(addressR, context, bloc.calculateTotalPrice().toString()),
            child: const Text("Buy"),
          ),
        );
      },
    );
  }
}

class ShowQuantityDetaild extends StatelessWidget {
  final int quantity;
  final dynamic product;
  final int price;
  const ShowQuantityDetaild(
      {super.key,
      required this.quantity,
      required this.product,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 20,
          child: Text(
            '$quantity',
            style: const TextStyle(color: Colors.white),
          )),
      title: Text('price for one piece = ${product['price']}'),
      subtitle: Text('Total Price = $quantity * ${product['price']} = $price'),
    );

    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     Text('you requested $quantity ${product['name']} '),
    //     gapH4,
    //     Text('price for one piece = ${product['price']}'),
    //     gapH4,
    //     Text('Total Price = $quantity * ${product['price']} = $price')
    //   ],
    // );
  }
}
