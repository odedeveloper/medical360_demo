import "package:flutter/material.dart";

import '../constants.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            myDrawer,
            Column(
              children: const [
                Text("Welcome Joe !"),
                Text("You can search here for any Query"),
              ]
            )
            

          ]
        )
      )
      
    );
  }
}