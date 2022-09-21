import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = BlocProvider.of<HomeCubit>(context);
        switch (state.runtimeType) {
          case GetDofd:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Deal of the day",
                      style: TextStyle(fontSize: 20),
                    )),
                Image.network(
                  bloc.dealofDay!.images[0],
                  width: context.width,
                  height: context.height * .2,
                  fit: BoxFit.cover,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      bloc.dealofDay!.name,
                      style: const TextStyle(fontSize: 20),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${bloc.dealofDay!.price} \$",
                      style: const TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.dealofDay!.images.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            bloc.dealofDay!.images[i],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                gapH10,
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "See all deals",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            );
        }
      },
    );
  }
}
