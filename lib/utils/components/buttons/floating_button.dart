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
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(1, 2),
          ),
        ],
      ),
      height: 36,
      child: FloatingActionButton.extended(
        splashColor: MyColor.primaryPressed,
        hoverColor: MyColor.primaryHover,
        tooltip: toolTip,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        backgroundColor: MyColor.primaryMain,
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
