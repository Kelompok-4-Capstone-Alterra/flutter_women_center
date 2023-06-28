import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class ReadOnlyTextBox extends StatelessWidget {
  final String value;
  final double? width;
  final IconButton? suffixIcon;
  final Color? textColor;

  const ReadOnlyTextBox({
    super.key,
    required this.value,
    this.width,
    this.suffixIcon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? MySize.bodyWidth(context) : width!,
      child: TextFormField(
        initialValue: value,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor ?? MyColor.neutralHigh,
        ),
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 24.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.neutralMediumLow,
              width: .25,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.neutralMediumLow,
              width: .25,
            ),
          ),
          suffixIcon: suffixIcon,
        ),
        readOnly: true,
      ),
    );
  }
}
