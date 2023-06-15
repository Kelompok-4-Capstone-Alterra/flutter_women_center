import 'package:flutter/material.dart';

import '../../my_color.dart';
import '../../my_size.dart';

class OutlineButton extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final double? customHeight;
  final Color? customBackgroundColor;
  final Color? customTextColor;
  final void Function()? onPressed;

  const OutlineButton({
    Key? key,
    this.customWidth,
    this.customHeight,
    this.customBackgroundColor,
    this.customTextColor,
    required this.teks,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return customTextColor ?? MyColor.primaryMain;
          },
        ),
        elevation: MaterialStateProperty.all<double>(0),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
            customWidth == null ? MySize.bodyWidth(context) : customWidth!,
            customHeight == null ? 44 : customHeight!,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return BorderSide(color: MyColor.primaryPressed);
            } else if (states.contains(MaterialState.hovered)) {
              return BorderSide(color: MyColor.primaryHover);
            } else if (states.contains(MaterialState.disabled)) {
              return BorderSide(color: MyColor.primarySurface);
            }
            return BorderSide(color: MyColor.primaryMain);
          },
        ),
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
