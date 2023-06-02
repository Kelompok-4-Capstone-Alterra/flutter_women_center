import 'package:capstone_project/view/screen/saved/widgets/horizontal_article_card.dart';
import 'package:capstone_project/view/screen/saved/widgets/article_list_popup_menu_button.dart';
import 'package:flutter/material.dart';
import '../../../../utils/my_color.dart';

class SavedCard extends StatelessWidget {
  final TextEditingController editListNameTextEditingController;
  final TextEditingController editDescriptionTextEditingController;
  final FocusNode editListNameFocusNode;
  final FocusNode editDescriptionFocusNode;
  final String judulList;

  const SavedCard({
    super.key,
    required this.judulList,
    required this.editListNameTextEditingController,
    required this.editDescriptionTextEditingController,
    required this.editListNameFocusNode,
    required this.editDescriptionFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 361,
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
              height: 157,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          judulList,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'List\'s Name',
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
                          '2 Articles',
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    'This is a description of this reading list.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 196,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: .25, color: MyColor.neutralMediumLow),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const HorizontalArticleCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
