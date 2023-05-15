import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class PrimaryButtonIcon extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final Widget widget;
  final void Function()? onPressed;

  const PrimaryButtonIcon({
    super.key,
    this.customWidth,
    required this.teks,
    required this.widget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.primaryColor,
          elevation: 0,
          fixedSize: Size(
              customWidth == null ? MySize.width(context) : customWidth!, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        onPressed: onPressed,
        label: Text(
          teks,
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: MyColor.white),
        ),
        icon: widget);
  }
}
