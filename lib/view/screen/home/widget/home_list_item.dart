import 'package:flutter/material.dart';

import '../../../../utils/my_color.dart';

class HomeListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String direction;
  final Widget? extraWidget;

  const HomeListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.direction,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (direction != '') {
          Navigator.pushNamed(context, direction);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: MyColor.neutralLow,
            width: .5,
          ),
        ),
        width: 135,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 116,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(3),
                ),
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: MyColor.neutralMediumLow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.neutralHigh,
                ),
                textAlign: TextAlign.center,
                maxLines: extraWidget == null ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (extraWidget != null) extraWidget!,
          ],
        ),
      ),
    );
    ;
  }
}
