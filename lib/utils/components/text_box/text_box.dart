import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? initialValue;
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
  final bool? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final double? width;

  const TextBox({
    super.key,
    this.width,
    required this.textEditingController,
    required this.hintText,
    this.onFieldSubmitted,
    this.textInputAction,
    this.currentFocus,
    this.last,
    this.initialValue,
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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? MySize.width(context) : width!,
      height: 44,
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
        initialValue: initialValue,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization == null
            ? TextCapitalization.none
            : textCapitalization!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: MyColor.info,
        ),
        autofocus: autoFocus == null || autoFocus == false ? false : true,
        obscureText: obscureText == null || obscureText == false ? false : true,
        obscuringCharacter:
            obscureText == null || obscureText == false || obscureChar == ''
                ? ' '
                : obscureChar!,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 24.0,
          ),
          isDense: true,
          prefixIconColor: Colors.blue,
          errorMaxLines: errorMaxLines,
          hintMaxLines: hintMaxLines,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyColor.subInfo,
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
