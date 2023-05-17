import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class PrimaryButtonIcon extends StatelessWidget {
  final String teks;
  final double? customWidth;
  final double? customHeight;
  final Widget widget;
  final void Function()? onPressed;

  const PrimaryButtonIcon({
    super.key,
    this.customWidth,
    this.customHeight,
    required this.teks,
    required this.widget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
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
            return MyColor.primaryMain;
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
      label: Text(
        teks,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: MyColor.white,
        ),
      ),
      icon: widget,
    );
  }
}
