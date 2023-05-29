import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool? autoFocus;
  final String? obscureChar;
  final bool? obscureText;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? currentFocus;
  final bool? last;
  final void Function(String)? onFieldSubmitted;
  final double? width;
  final IconButton? suffixIcon;

  const TextBox({
    super.key,
    this.width,
    required this.textEditingController,
    required this.hintText,
    this.onFieldSubmitted,
    this.currentFocus,
    this.last,
    this.keyboardType,
    this.textCapitalization,
    this.autoFocus,
    this.obscureChar,
    this.obscureText,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.errorMaxLines,
    this.hintMaxLines,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? MySize.bodyWidth(context) : width!,
      child: TextFormField(
        controller: textEditingController,
        focusNode: currentFocus,
        onFieldSubmitted: last == true
            ? (value) {
                currentFocus!.unfocus();
              }
            : onFieldSubmitted,
        textInputAction: last == null || last == false
            ? TextInputAction.next
            : TextInputAction.done,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization == null
            ? TextCapitalization.none
            : textCapitalization!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: MyColor.neutralHigh,
        ),
        autofocus: autoFocus == null || autoFocus == false ? false : true,
        obscureText: obscureText == null || obscureText == false ? false : true,
        obscuringCharacter:
            obscureText == null || obscureText == false || obscureChar == ''
                ? '*'
                : obscureChar!,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 24.0,
          ),
          isDense: true,
          errorMaxLines: errorMaxLines,
          hintMaxLines: hintMaxLines,
          hintText: hintText,
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
              color: MyColor.primaryMain,
              width: .25,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: MyColor.danger,
              width: .25,
            ),
          ),
          suffixIcon: suffixIcon,
        ),
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
