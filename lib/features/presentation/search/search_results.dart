import 'package:amazon/constants/device_size.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchResut extends StatelessWidget {
  List<Product> products;
  SearchResut({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: const Text("result")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            width: context.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Image.network(
                    width: context.width * .3,
                    height: 200,
                    products[index].images[0])
              ],
            ),
          );
        },
      ),
    );
  }
}
