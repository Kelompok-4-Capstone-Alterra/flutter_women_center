import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/saved/widgets/article_popup_menu_button.dart';
import 'package:flutter/material.dart';

class HorizontalArticleCard extends StatelessWidget {
  const HorizontalArticleCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80',
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
                    'How to improve your skill as a woman?',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  Text(
                    'Kim Jennie',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                  Text(
                    '23 March 2023',
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
          const ArticlePopupMenuButton(deleteEvent: null),
        ],
      ),
    );
  }
}
