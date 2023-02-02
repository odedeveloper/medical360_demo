import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vault/constants.dart';
import 'package:vault/utils/constant.dart';
import 'package:vault/utils/responsive.dart';
import 'package:vault/widgets/custom_appbar_widget.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:vault/widgets/drawer_menu.dart';

const url = "https://oth-demo.oth.io/client-citizen/#/login";

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: CustomAppBarWidget(
                  title: drawerApps,
                  subTitle: appsSubTitle,
                ),
              ),
              const Expanded(flex: 6, child: AppCard())
            ]));
  }
}

class AppCard extends StatelessWidget {
  const AppCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: 95,
      child: InkWell(
        onTap: () async {
          if (Responsive.isDesktop(context)) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
            // forceSafariVC: true,
            // forceWebView: true,
            // enableJavaScript: true);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InAppWebView(
                            initialUrlRequest: URLRequest(
                          url: Uri.parse(url),
                        ))));
            GestureDetector(onTap: () {
              Get.back();
            });
          }
        },
        child: Column(
          children: [
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 6,
                        blurRadius: 6,
                        color: Color.fromARGB(255, 223, 238, 222),
                      )
                    ]),
                child: Image.asset(
                  mediclinician,
                  height: 40,
                  width: 40,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              "MediClinician",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
