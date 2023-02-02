import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vault/controllers/dashboard_controller.dart';
import 'package:vault/ui/medical-integration/second_screen.dart';
import 'package:vault/utils/constant.dart';
import 'package:vault/utils/responsive.dart';
import 'package:hexcolor/hexcolor.dart';

class DrawerMenu extends GetWidget<DashBoardController> {
  const DrawerMenu({Key? key}) : super(key: key);

  void onAddButtonTapped(int index) {
    controller.contentpageSelection.jumpToPage(index);
    controller.contentcurrentPageIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // void onAddButtonTapped(int index) {
    //   controller.contentpageSelection.jumpToPage(index);
    //   controller.contentcurrentPageIndex(index);
    // }

    return SafeArea(
      child: Drawer(
        elevation: 0,
        backgroundColor: HexColor("#BAE6DC"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: kmaxExtraLargeFont(context)! + 15,
                      backgroundColor: kbottomBoxColor,
                      child: Image.asset(medimeLogo)
                      // SvgPicture.asset(
                      //   appLogo,
                      //   height: kextraLargeFont(context)! + 15,
                      // ),
                      ),
                  const SizedBox(width: 10),
                  Text("Medical-360", style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 40),
              DrawerButtons(
                title: "Analytics",
                icon: Icons.analytics,
                pageIndex: 0,
                onClicked: () {
                  if (!Responsive.isDesktop(context)) Navigator.pop(context);
                  onAddButtonTapped(0);
                },
              ),
              DrawerButtons(
                title: drawerApps,
                icon: Icons.medical_services,
                pageIndex: 1,
                onClicked: () {
                  if (!Responsive.isDesktop(context)) Navigator.pop(context);
                  onAddButtonTapped(1);
                },
              ),
              const SizedBox(height: 20),
              Spacer(),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ODE K",
                    style: themeTextStyle(
                      context: context,
                      tColor: kdarkTeal,
                      fontFamily: "Raleway",
                      fweight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fsize: kextraLargeFont(context),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "medical360@yopmail.com",
                    style: themeTextStyle(
                      context: context,
                      tColor: kdarkTeal,
                      fontFamily: "Raleway",
                      fweight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.help,
                      size: height(context)! * 0.03,
                      color: kdarkTeal,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: height(context)! * 0.03,
                      color: kdarkTeal,
                    ),
                    onPressed: () async {
                      // GetStorage deviceStorage = GetStorage();
                      // await deviceStorage.erase();
                      // Get.offAllNamed(AppRoutes.splash);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerButtons extends GetWidget<DashBoardController> {
  final VoidCallback? onClicked;
  final String? title;
  final IconData? icon;
  final int? pageIndex;
  const DrawerButtons({
    Key? key,
    this.icon,
    this.pageIndex,
    this.title,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: onClicked,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
            color: controller.contentcurrentPageIndex.value == pageIndex
                ? kteal
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: kmaxExtraLargeFont(context),
                  color: controller.contentcurrentPageIndex.value == pageIndex
                      ? kwhite
                      : null,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    title!,
                    style: themeTextStyle(
                      context: context,
                      fweight:
                          controller.contentcurrentPageIndex.value == pageIndex
                              ? FontWeight.bold
                              : null,
                      tColor:
                          controller.contentcurrentPageIndex.value == pageIndex
                              ? kwhite
                              : ktextColor,
                      fsize: klargeFont(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
