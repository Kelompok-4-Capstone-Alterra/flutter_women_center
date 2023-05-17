import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final double? customHeight;
  final void Function()? onPressed;

  const PrimaryButton({
    super.key,
    this.customWidth,
    this.customHeight,
    required this.teks,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColor.primary,
        elevation: 0,
        fixedSize: Size(
          customWidth == null ? MySize.width(context) : customWidth!,
          customHeight == null ? 44 : customHeight!,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        teks,
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w500, color: MyColor.white),
      ),
    );
  }
}
