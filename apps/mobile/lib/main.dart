import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:budipest/ui/home/home.dart';
import 'package:budipest/theme.dart';

void main() => runApp(Budipest());

class Budipest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Get.put(AppTheme());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budipest',
      theme: theme.light(),
      darkTheme: theme.dark(),
      home: Home(),
    );
  }
}
