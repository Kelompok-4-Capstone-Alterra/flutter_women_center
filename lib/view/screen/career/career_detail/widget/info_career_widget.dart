import 'package:flutter/material.dart';

import '../../../../../../utils/my_color.dart';

class InfoCareerWidget extends StatelessWidget {
  const InfoCareerWidget(
      {super.key, required this.icon, required this.infoCareer});

  final Icon icon;
  final String infoCareer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 12),
        SizedBox(
          child: Text(
            infoCareer,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: MyColor.neutralHigh,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
