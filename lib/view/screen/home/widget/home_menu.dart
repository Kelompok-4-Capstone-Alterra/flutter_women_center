import 'package:flutter/material.dart';

import '../../../../utils/my_color.dart';

class HomeMenu extends StatelessWidget {
  final IconData icon;
  final String direction;
  final String title;

  const HomeMenu(
      {super.key,
      required this.icon,
      required this.direction,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: MyColor.primaryMain,
          radius: 32,
          child: IconButton(
            onPressed: () {
              if (direction != '') {
                Navigator.pushNamed(context, direction);
              }
            },
            icon: Icon(
              icon,
              size: 30,
              color: MyColor.white,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: MyColor.neutralHigh,
          ),
        ),
      ],
    );
  }
}
