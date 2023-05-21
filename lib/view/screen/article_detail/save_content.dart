import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/text_action_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class SaveContent extends StatelessWidget {
  const SaveContent({super.key});

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
                  "Save to ...",
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
                Text(
                  "Create new list ...",
                  style:
                      TextStyle(fontSize: 16, color: MyColor.secondaryPressed),
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Text(
                  "Heal my inner child  ",
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
                  "Trust issues",
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
                  "Improving my skills",
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
                  "Self Development",
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
