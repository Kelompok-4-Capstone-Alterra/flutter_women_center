import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/saved/widgets/article_popup_menu_button.dart';
import 'package:flutter/material.dart';

class VerticalArticleCard extends StatelessWidget {
  final void Function()? deleteEvent;
  final String articleImageLink;
  final String articleTitle;
  final String articleAuthor;
  final String articleCategory;

  const VerticalArticleCard({
    super.key,
    required this.deleteEvent,
    required this.articleImageLink,
    required this.articleTitle,
    required this.articleAuthor,
    required this.articleCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: MyColor.neutralLow, width: .5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            child: !articleImageLink.startsWith('https://')
                ? const SizedBox(
                    width: 135, height: double.infinity, child: Placeholder())
                : Image.network(
                    articleImageLink,
                    fit: BoxFit.fill,
                    width: 135,
                  ),
          ),
          SizedBox(
            height: double.infinity,
            width: 167,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    articleTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  Text(
                    articleAuthor,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                  Text(
                    articleCategory,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ArticlePopupMenuButton(
                  deleteEvent: deleteEvent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
