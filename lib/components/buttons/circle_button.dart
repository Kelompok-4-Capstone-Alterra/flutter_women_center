import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget widget;
  final void Function()? onPressed;

  const CircleButton({
    super.key,
    required this.widget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.primaryColor,
          elevation: 0,
          fixedSize: const Size(56, 56),
          shape: const CircleBorder(),
        ),
        onPressed: onPressed,
        child: widget);
  }
}
