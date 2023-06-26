import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final IconData customIcon;
  final String category;
  final String direction;

  const CategoryBox({
    super.key,
    required this.customIcon,
    required this.category,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        height: 80,
        width: 150,
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, direction);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
              side: BorderSide(
                color: MyColor.primaryMain,
                width: 1,
              ),
            ),
            leading: Icon(
              customIcon,
              color: MyColor.primaryMain,
            ),
            horizontalTitleGap: 0,
            title: Text(
              category,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: MyColor.neutralHigh,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
