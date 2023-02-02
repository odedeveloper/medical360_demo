import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vault/ui/analytics/analytics_screen.dart';
import 'package:vault/ui/medical-integration/second_screen.dart';

class DashBoardController extends GetxController {
  PageController _contentpageSelection = PageController(initialPage: 0);
  RxInt contentcurrentPageIndex = 0.obs;

  PageController get contentpageSelection {
    return _contentpageSelection;
  }

  set contentpageSelection(PageController i) {
    _contentpageSelection = i;
    update();
  }

  List<Widget> dashboardScreens = [
    AnalyticsScreen(),
    SecondScreen(),
    // AnalyticsScreen(),
    // MedicalProviderScreen(),
    // const MeasurementsScreen(),
    // const HomeScreen(),
    // const ConsentScreen(),
    // const QuestionnairesScreen(),
    // const RecordScreen(),
    // PaymentScreen(),
  ];
}
