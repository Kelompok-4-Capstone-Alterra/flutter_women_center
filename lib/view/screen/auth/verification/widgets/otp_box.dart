import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../utils/my_color.dart';

class OtpBox extends StatelessWidget {
  const OtpBox({super.key, required this.onChanged});

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: MyColor.primaryMain,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.primaryBorder,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.primaryBorder,
              width: .5,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.danger,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.primaryBorder,
              width: 2,
            ),
          ),
        ),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
