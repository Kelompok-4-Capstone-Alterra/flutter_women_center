import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/text_action_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: MySize.screenHeight(context) * 0.08,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: MyColor.neutralMediumLow,
                  width: 0.3,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  "Sort By",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextActionButton(
                  teks: 'cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Text(
                  "Most Viewed",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Icon(
                  Icons.check,
                  color: MyColor.primaryMain,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: const [
                Text(
                  "Newest",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: const [
                Text(
                  "Older",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 44,
            width: double.infinity,
            child: PrimaryButton(
              teks: 'Save',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}