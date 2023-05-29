import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final double? customHeight;
  final Color? customBackgroundColor;
  final Color? customTextColor;
  final void Function()? onPressed;

  const PrimaryButton({
    super.key,
    this.customWidth,
    this.customHeight,
    this.customBackgroundColor,
    this.customTextColor,

    required this.teks,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return MyColor.primaryPressed;
            } else if (states.contains(MaterialState.hovered)) {
              return MyColor.primaryHover;
            } else if (states.contains(MaterialState.disabled)) {
              return MyColor.primarySurface;
            }
            return customBackgroundColor ?? MyColor.primaryMain;

          },
        ),
        foregroundColor: MaterialStatePropertyAll<Color>(MyColor.white),
        elevation: const MaterialStatePropertyAll<double>(0),
        fixedSize: MaterialStatePropertyAll<Size>(Size(
          customWidth == null ? MySize.bodyWidth(context) : customWidth!,
          customHeight == null ? 44 : customHeight!,
        )),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
      ),
      onPressed: onPressed,
      child: Text(
        teks,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: customTextColor ?? MyColor.white,

        ),
      ),
    );
  }
}
