import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class TransactionAppbar extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;

  const TransactionAppbar(
      {super.key, required this.textEditingController, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MySize.width(context),
      height: 178.0,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 42),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColor.info,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SearchTextBox(textEditingController: textEditingController),
        ],
      ),
    );
  }
}
