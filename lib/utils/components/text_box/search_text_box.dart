import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchTextBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final void Function(String)? onChanged;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final double? width;

  const SearchTextBox({
    super.key,
    this.width,
    required this.textEditingController,
    this.keyboardType,
    this.textCapitalization,
    this.maxLength,
    this.onChanged,
    this.errorMaxLines,
    this.hintMaxLines,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? MySize.bodyWidth(context) : width!,
      height: 48,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization == null
            ? TextCapitalization.none
            : textCapitalization!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: MyColor.neutralMediumLow,
        ),
        maxLength: maxLength,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 24.0,
          ),
          prefixIcon: const Icon(Icons.search),
          errorMaxLines: errorMaxLines,
          hintMaxLines: hintMaxLines,
          hintText: 'Find something here ...',
          hintStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyColor.neutralMediumLow,
          ),
          errorStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyColor.danger,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.primaryMain, width: .25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.neutralMediumLow, width: .25),
          ),
        ),
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
