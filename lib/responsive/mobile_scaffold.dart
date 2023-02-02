import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vault/constants.dart';
import 'package:http/http.dart' as http;
import 'package:vault/controllers/dashboard_controller.dart';
import 'package:vault/controllers/filter_controller.dart';
import 'dart:convert';
import 'package:vault/controllers/search_controller.dart';
import 'package:vault/controllers/filter_controller.dart';
import 'package:vault/controllers/chart_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vault/utils/responsive.dart';
import 'package:vault/widgets/custom_drawerappbar_widget.dart';
import 'package:vault/widgets/drawer_menu.dart';

class MobileScaffold extends GetWidget<DashBoardController> {
  MobileScaffold({super.key});

  // instance of Controllers:
  var data;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#E2FBF2"),
      drawer: DrawerMenu(),
      appBar: Responsive.isDesktop(context)
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: CustomDrawerAppBar(),
            ),
      // AppBar(
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     foregroundColor: Colors.grey,
      //     leading: Builder(builder: (BuildContext context) {
      //       return IconButton(
      //         icon: Icon(Icons.accessible),
      //         onPressed: () => Scaffold.of(context).openDrawer(),
      //       );
      //     })

      //     // title: const Text("Enterprise Data Vault"),
      //     ),
      body: Row(
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(child: DrawerMenu()),
          Expanded(
            flex: 4,
            child: PageView(
              controller: controller.contentpageSelection,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.dashboardScreens,
            ),
          ),
        ],
      ),
    );
  }
}
