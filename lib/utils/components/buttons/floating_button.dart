import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String? toolTip;
  final void Function()? onPressed;
  final Widget widget;
  final String teks;

  const FloatingButton({
    super.key,
    this.toolTip,
    required this.widget,
    required this.teks,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: FloatingActionButton.extended(
        tooltip: toolTip,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        backgroundColor: MyColor.primary,
        foregroundColor: MyColor.white,
        elevation: 0,
        icon: widget,
        label: Text(
          teks,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: MyColor.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
