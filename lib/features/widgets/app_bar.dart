import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';

PreferredSize getAppBar({required Widget title, List<Widget>? widgets}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      actions: widgets,
      title: title,
      flexibleSpace: Container(
        decoration:
            const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      ),
    ),
  );
}
