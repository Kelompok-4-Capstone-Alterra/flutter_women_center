import 'package:flutter/material.dart';
import '../../../../utils/components/alert_dialog/custom_alert_dialog_builder.dart';
import '../../../../utils/components/pop_up_menu_button/custom_pop_up_menu_button.dart';
import '../../../../utils/my_color.dart';

class ArticlePopupMenuButton extends StatelessWidget {
  final void Function()? sureOnPressed;

  const ArticlePopupMenuButton({
    super.key,
    required this.sureOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Text(
              'Remove from list',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.danger,
              ),
            ),
          ),
        ];
      },
      onSelected: (value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black12,
          builder: (context) {
            return CustomAlertDialogBuilder(
              judul: 'Are you sure want to delete this from the list?',
              sureOnPressed: sureOnPressed,
            );
          },
        );
      },
    );
  }
}
