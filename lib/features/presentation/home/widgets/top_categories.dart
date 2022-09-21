import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/admin_screen.dart';
import 'package:amazon/features/presentation/admin_screen/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> list = GlobalVariables.categoryImages;
    return SizedBox(
      height: context.width * .2,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemCount: list.length,
        itemBuilder: (context, index) {
          var category = list[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () =>
                    goToArgumentsNamed(categoryR, context, category['title']!),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      category['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
              gapH4,
              Expanded(child: Text(category['title']!))
            ],
          );
        },
      ),
    );
  }
}
