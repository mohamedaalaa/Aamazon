import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/presentation/admin_screen/cubit/cubit/admin_cubit.dart';
import 'package:amazon/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';

class ShowDialog extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const ShowDialog({
    Key? key,
    required this.title,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(title),
      actions: actions,
    );
  }
}
