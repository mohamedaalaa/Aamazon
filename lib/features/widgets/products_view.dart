import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/presentation/admin_screen/widgets.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  List<Product> products;
  ProductsView({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return MyProduct(
          product: products[index],
        );
      },
    );
  }
}

class MyProduct extends StatelessWidget {
  final Product product;

  MyProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                product.name,
                textAlign: TextAlign.center,
              ),
              leading: Text(
                "${product.price} \$",
                style: const TextStyle(color: Colors.white),
              ),
              trailing: getUser.type == "admin"
                  ? IconButton(
                      onPressed: () => showMyDialog(
                          context: context,
                          title: "Delete Product",
                          alert1: "Delete Product",
                          alert2: "Are You sure?",
                          id: product.id),
                      icon: const Icon(Icons.delete_outline))
                  : null),
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
