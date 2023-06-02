import 'package:flutter/material.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_pop_up_menu_button.dart';
import '../../../../utils/my_color.dart';

class ArticlePopupMenuButton extends StatelessWidget {
  final void deleteEvent;

  const ArticlePopupMenuButton({
    super.key,
    required this.deleteEvent,
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
        deleteEvent;
      },
    );
  }
}
