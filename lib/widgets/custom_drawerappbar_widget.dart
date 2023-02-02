import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vault/controllers/dashboard_controller.dart';
import 'package:vault/utils/constant.dart';
import 'package:vault/utils/responsive.dart';

class CustomDrawerAppBar extends StatelessWidget {
  const CustomDrawerAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("#E2FBF2"),
      elevation: 0.0,
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Image.asset(
        medimeLogo,
        height: 60,
      ),
      leading: !Responsive.isDesktop(context)
          ? IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            )
          : null,
      actions: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notification_important))
      ],
    );
  }
}
