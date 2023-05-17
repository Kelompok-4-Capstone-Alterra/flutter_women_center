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
          elevation: const MaterialStatePropertyAll<double>(0),
          fixedSize: const MaterialStatePropertyAll<Size>(Size(56, 56)),
          shape: const MaterialStatePropertyAll<CircleBorder>(CircleBorder()),
        ),
        onPressed: onPressed,
        child: widget);
  }
}
