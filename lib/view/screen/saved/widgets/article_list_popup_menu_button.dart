import 'package:flutter/material.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_pop_up_menu_button.dart';
import '../../../../utils/my_color.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';

class ArticleListPopupMenuButton extends StatelessWidget {
  final TextEditingController editListNameTextEditingController;
  final TextEditingController editDescriptionTextEditingController;
  final FocusNode editListNameFocusNode;
  final FocusNode editDescriptionFocusNode;

  const ArticleListPopupMenuButton({
    super.key,
    required this.editListNameTextEditingController,
    required this.editDescriptionTextEditingController,
    required this.editListNameFocusNode,
    required this.editDescriptionFocusNode,
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
            builder: (context) {
              return CustomBottomSheetBuilder(
                header: true,
                tinggi: 680,
                judul: 'Edit List Info',
                isi: [
                  SizedBox(
                    height: 72,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List Name',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                        TextBox(
                          textEditingController:
                              editListNameTextEditingController,
                          hintText:
                              'Ex : How to heal my traumatized inner child',
                          currentFocus: editListNameFocusNode,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 72,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description (optional)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                        TextBox(
                          textEditingController:
                              editDescriptionTextEditingController,
                          last: true,
                          hintText: 'Ex : This is an important list',
                          currentFocus: editDescriptionFocusNode,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                    teks: 'Save Changes',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          //untuk delete event
        }
      },
    );
  }
}
