import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_demo/overlay_manager.dart';
import 'package:overlay_demo/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      initialRoute: Routes.home,
      getPages: Routes.getPages,
      builder: (BuildContext context, Widget? child) {
        return Overlay(initialEntries: [
          if (child != null) ...[OverlayEntry(builder: (context) => child)],
          globalOverlayEntry
        ]);
      },
    );
  }
}
