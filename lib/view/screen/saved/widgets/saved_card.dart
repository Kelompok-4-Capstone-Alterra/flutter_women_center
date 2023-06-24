import 'package:capstone_project/view/screen/saved/widgets/article_list_popup_menu_button.dart';
import 'package:flutter/material.dart';
import '../../../../utils/my_color.dart';

class SavedCard extends StatelessWidget {
  final TextEditingController editListNameTextEditingController;
  final TextEditingController editDescriptionTextEditingController;
  final FocusNode editListNameFocusNode;
  final FocusNode editDescriptionFocusNode;
  final String judulList;
  final int totalArtikel;
  final String deskripsi;
  final Widget? daftarArtikel;
  final void Function()? deleteEvent;
  final void Function()? cancelEvent;
  final Widget Function(BuildContext) editReadingListBottomSheetBuilder;

  const SavedCard({
    super.key,
    required this.judulList,
    required this.totalArtikel,
    required this.deskripsi,
    required this.daftarArtikel,
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
    return SizedBox(
      width: double.infinity,
      height: daftarArtikel == null ? 126 : 322,
      child: Card(
        elevation: 0.0,
        color: MyColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: MyColor.neutralLow,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 118,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judulList,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColor.primaryMain,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          totalArtikel == 0
                              ? 'No Article Yet'
                              : totalArtikel == 1
                                  ? '${totalArtikel.toString()} Article'
                                  : '${totalArtikel.toString()} Articles',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                        ArticleListPopupMenuButton(
                          editListNameTextEditingController:
                              editListNameTextEditingController,
                          editDescriptionTextEditingController:
                              editDescriptionTextEditingController,
                          editListNameFocusNode: editListNameFocusNode,
                          editDescriptionFocusNode: editDescriptionFocusNode,
                          editReadingListBottomSheetBuilder:
                              editReadingListBottomSheetBuilder,
                          deleteEvent: deleteEvent,
                          cancelEvent: cancelEvent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    deskripsi,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                ],
              ),
            ),
            daftarArtikel == null
                ? const SizedBox()
                : Container(
                    height: 196,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: .25, color: MyColor.neutralMediumLow),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: daftarArtikel,
                  ),
          ],
        ),
      ),
    );
  }
}
