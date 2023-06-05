import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class HomeList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String direction;
  final Widget listItem;

  const HomeList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.direction,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColor.neutralHigh,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: MyColor.neutralMediumLow,
                  ),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (direction != '') {
                  Navigator.pushNamed(context, direction);
                }
              },
              child: Text(
                'Find More',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: MyColor.primaryMain,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(height: 190, child: listItem),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }
}
