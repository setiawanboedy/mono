import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:budipest/repositories/toilet/toilet_repository.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text('Clicks: ${c.count}'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => Get.to(() => Other()),
            child: const Text('Navigate'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
            child: const Text('Toggle dark mode'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Other extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('The count is ${c.count}')));
  }
}
