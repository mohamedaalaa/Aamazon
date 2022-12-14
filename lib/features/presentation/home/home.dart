import 'package:amazon/constants/device_size.dart';
import 'package:amazon/features/presentation/home/widgets/address_box.dart';
import 'package:amazon/features/presentation/home/widgets/carousel.dart';
import 'package:amazon/features/presentation/home/widgets/deal_of_day.dart';
import 'package:amazon/features/presentation/home/widgets/top_categories.dart';
import 'package:amazon/features/presentation/search/search_screen.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    height: 42,
                    child: IconButton(
                        onPressed: () => showSearch(
                            context: context, delegate: SearchScreen()),
                        icon: const Icon(Icons.search))
                    // TextFormField(
                    //   onChanged: (value) => showSearch(context: context, delegate: Sear),
                    //   controller: searchController,
                    //   decoration: const InputDecoration(
                    //     hoverColor: Colors.black,
                    //     border: InputBorder.none,
                    //     hintText: 'Search',
                    //     hintStyle: TextStyle(color: Colors.grey),
                    //     prefixIcon: Padding(
                    //       padding: EdgeInsets.only(left: 10, right: 10),
                    //       child: Icon(
                    //         Icons.search,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
            ],
          ),
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AddressBox(),
            gapH10,
            const TopCategories(),
            CarouselPhotos(
              images: GlobalVariables.carouselImages,
              height: context.height * .3,
            ),
            gapH10,
            const DealOfDay(),
          ],
        ),
      ),
    );
  }
}
