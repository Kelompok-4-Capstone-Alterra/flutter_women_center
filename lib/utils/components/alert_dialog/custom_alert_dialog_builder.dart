import 'package:capstone_project/utils/components/buttons/outline_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogBuilder extends StatelessWidget {
  final String judul;
  final void Function()? sureOnPressed;

  const CustomAlertDialogBuilder({
    super.key,
    required this.judul,
    required this.sureOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        side: BorderSide(
          color: MyColor.neutralMediumLow,
          width: .25,
        ),
      ),
      elevation: 0,
      backgroundColor: MyColor.white,
      child: Container(
        padding: const EdgeInsets.all(24),
        height: 208,
        width: 293,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              judul,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: MyColor.neutralHigh,
              ),
              maxLines: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              teks: 'Sure',
              customHeight: 36,
              onPressed: sureOnPressed,
            ),
            const SizedBox(
              height: 8,
            ),
            OutlineButton(
              teks: 'Maybe Later',
              customHeight: 36,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
