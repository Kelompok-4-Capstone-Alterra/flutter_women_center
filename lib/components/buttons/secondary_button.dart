import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final void Function()? onPressed;

  const SecondaryButton({
    super.key,
    this.customWidth,
    required this.teks,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
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
      onPressed: onPressed,
      child: Text(
        teks,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: MyColor.primary),
      ),
    );
  }
}
