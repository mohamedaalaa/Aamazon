import 'dart:io';

import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CarouselPhotos extends StatelessWidget {
  final List<String> images;
  final double height;

  const CarouselPhotos({
    super.key,
    required this.images,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // List<String> images = GlobalVariables.carouselImages;
    return CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1,
          autoPlay: true,
        ),
        items: images.map((path) {
          return Builder(
            builder: (context) {
              return Container(
                  width: context.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    path,
                    fit: BoxFit.cover,
                  ));
            },
          );
        }).toList());
  }
}

class CarouselFiles extends StatelessWidget {
  final List<File> images;
  final double height;

  const CarouselFiles({
    super.key,
    required this.images,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // List<String> images = GlobalVariables.carouselImages;
    return CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1,
          autoPlay: true,
        ),
        items: images.map((file) {
          return Builder(
            builder: (context) {
              return Container(
                  width: context.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ));
            },
          );
        }).toList());
  }
}
