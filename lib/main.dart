import 'package:flutter/material.dart';
import 'package:vault/controllers/dashboard_controller.dart';
import 'package:vault/responsive/desktop_scaffold.dart';
import 'package:vault/responsive/mobile_scaffold.dart';
import 'package:vault/responsive/responsive_layout.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final aa = Get.put(DashBoardController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Medical-360 demo',
        theme: ThemeData(
          fontFamily: "Quicksand",
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        home: ResponsiveLayout(
          mobileScaffold: MobileScaffold(),
          desktopScaffold: const DesktopScaffold(),
        ));
  }
}
