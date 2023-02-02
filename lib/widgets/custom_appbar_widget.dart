import 'package:flutter/material.dart';
import 'package:vault/utils/constant.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const CustomAppBarWidget({
    Key? key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title!,
          style: TextStyle(
            fontFamily: ralewayFont,
            fontSize: 23,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subTitle!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
