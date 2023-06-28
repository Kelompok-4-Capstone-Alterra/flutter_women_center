import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class TextActionButton extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final double? customHeight;
  final void Function()? onPressed;

  const TextActionButton({
    super.key,
    this.customWidth,
    this.customHeight,
    required this.teks,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return MyColor.secondaryPressed;
            } else if (states.contains(MaterialState.hovered)) {
              return MyColor.secondaryHover;
            } else if (states.contains(MaterialState.disabled)) {
              return MyColor.secondarySurface;
            }
            return MyColor.white;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return MyColor.white;
            } else if (states.contains(MaterialState.hovered)) {
              return MyColor.white;
            } else if (states.contains(MaterialState.disabled)) {
              return MyColor.secondarySurface;
            }
            return MyColor.secondaryMain;
          },
        ),
        elevation: const MaterialStatePropertyAll<double>(0),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
      ),
      onPressed: onPressed,
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
