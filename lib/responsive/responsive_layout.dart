import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.mobileScaffold, required this.desktopScaffold});

  final Widget mobileScaffold;
  final Widget desktopScaffold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      // if (constraints.maxWidth < 500){
        return mobileScaffold;
      // }else {
        // return desktopScaffold;
      }
    );
  }
}