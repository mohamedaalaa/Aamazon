import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddRating extends StatelessWidget {
  final double rate;
  void Function(double) onRatingUpdate;
  AddRating({super.key, required this.rate, required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
