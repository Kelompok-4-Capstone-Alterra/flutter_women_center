import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class VerticalArticleCard extends StatelessWidget {
  const VerticalArticleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164,
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: MyColor.neutralLow, width: .5),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80',
              fit: BoxFit.fill,
              height: 114,
            ),
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Self Development',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralMediumLow,
                    ),
                  ),
                  Text(
                    'How to improve your skill as a woman?',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
