import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/cart_screen/cubit/cart_cubit.dart';
import 'package:amazon/features/presentation/home/cubit/home_cubit.dart';
import 'package:amazon/features/presentation/home/widgets/carousel.dart';
import 'package:amazon/features/widgets/app_bar.dart';
import 'package:amazon/features/widgets/elevated_button.dart';
import 'package:amazon/features/widgets/rating_bar.dart';
import 'package:amazon/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case RateDone:
                  showScaffold(context, "your rate sent successfully");
                  break;
                case AddedOrRemovedFromCart:
                  showScaffold(context, "product added to cart");
              }
            },
            builder: (context, state) {
              final bloc = BlocProvider.of<CartCubit>(context);

              print(product.id);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: AddRating(
                        rate: product.rating != null
                            ? bloc.getProductRate(product.rating!)
                            : 1,
                        onRatingUpdate: (rate) {},
                      )),
                  gapH10,
                  Text(product.name),
                  gapH10,
                  CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1,
                        autoPlay: true,
                      ),
                      items: product.images.map((url) {
                        return Builder(
                          builder: (context) {
                            return Container(
                                width: context.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:
                                    const BoxDecoration(color: Colors.amber),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.contain,
                                ));
                          },
                        );
                      }).toList()),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  gapH10,
                  RichText(
                      text: TextSpan(
                          text: "Deal Price",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          children: [
                        TextSpan(
                          text: " ${product.price} \$",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 22),
                        )
                      ])),
                  Text(
                    product.description,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  gapH10,
                  Ebutton(
                      color: Colors.yellow,
                      onPressed: null,
                      title: 'Buy now',
                      width: context.width),
                  gapH10,
                  if (state is AddOrRemoveFromCart)
                    const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  else
                    Ebutton(
                        color: Colors.yellow,
                        onPressed: () =>
                            bloc.addToCart(id: product.id, context: context),
                        title: 'Add to cart',
                        width: context.width),
                  gapH10,
                  const Text("Reat this product:"),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final bloc = BlocProvider.of<CartCubit>(context);
                      switch (state.runtimeType) {
                        case RateProduct:
                          return const LinearProgressIndicator();
                        default:
                          return AddRating(
                            rate: product.rating != null
                                ? bloc.getProductRate(product.rating!)
                                : 1,
                            onRatingUpdate: (rate) =>
                                bloc.rateProduct(context, product, rate),
                          );
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
