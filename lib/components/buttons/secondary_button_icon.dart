import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class SecondaryButtonIcon extends StatelessWidget {
  final String teks;
  final Widget widget;
  final double? customWidth;
  final void Function()? onPressed;

  const SecondaryButtonIcon({
    super.key,
    this.customWidth,
    required this.teks,
    required this.widget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: MyColor.white,
        elevation: 0,
        side: BorderSide(color: MyColor.primary, width: 1),
        fixedSize: Size(
            customWidth == null ? MySize.width(context) : customWidth!, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      icon: widget,
      onPressed: onPressed,
      label: Text(
        teks,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: MyColor.primary),
      ),
    );
  }
}
