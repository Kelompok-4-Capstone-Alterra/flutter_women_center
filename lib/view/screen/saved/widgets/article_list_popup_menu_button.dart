import 'package:capstone_project/utils/components/alert_dialog/custom_alert_dialog_builder.dart';
import 'package:flutter/material.dart';
import '../../../../utils/components/pop_up_menu_button/custom_pop_up_menu_button.dart';
import '../../../../utils/my_color.dart';

class ArticleListPopupMenuButton extends StatelessWidget {
  final TextEditingController editListNameTextEditingController;
  final TextEditingController editDescriptionTextEditingController;
  final FocusNode editListNameFocusNode;
  final FocusNode editDescriptionFocusNode;
  final void Function()? deleteEvent;
  final void Function()? cancelEvent;
  final Widget Function(BuildContext) editReadingListBottomSheetBuilder;

  const ArticleListPopupMenuButton({
    super.key,
    required this.editListNameTextEditingController,
    required this.editDescriptionTextEditingController,
    required this.editListNameFocusNode,
    required this.editDescriptionFocusNode,
    required this.deleteEvent,
    required this.editReadingListBottomSheetBuilder,
    this.cancelEvent,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Text(
              'Edit list info',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.neutralHigh,
              ),
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(
              'Delete list',
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
        if (value == 0) {
          showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            builder: editReadingListBottomSheetBuilder,
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black12,
            builder: (context) {
              return CustomAlertDialogBuilder(
                judul: 'Are you sure want to delete this list?',
                sureOnPressed: deleteEvent,
              );
            },
          );
        }
      },
    );
  }
}
