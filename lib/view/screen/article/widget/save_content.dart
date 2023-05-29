import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/text_action_button.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/components/text_box/text_box.dart';

import 'package:flutter/material.dart';

class SaveContent extends StatefulWidget {
  const SaveContent({super.key});

  @override
  State<SaveContent> createState() => _SaveContentState();
}

class _SaveContentState extends State<SaveContent> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController listNameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final FocusNode listNameNode = FocusNode();
    final FocusNode descriptionNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        children: [
          Row(
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isDismissible: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return CustomBottomSheetBuilder(
                          tinggi: 680,
                          header: true,
                          judul: 'Create New List',
                          isi: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'List Name',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.neutralHigh,
                                  ),
                                ),
                                TextBox(
                                  textEditingController: listNameController,
                                  hintText:
                                      'Ex : How to heal my traumatized inner child',
                                  currentFocus: listNameNode,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Description (optional)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.neutralHigh,
                                  ),
                                ),
                                TextBox(
                                  textEditingController: descriptionController,
                                  last: true,
                                  hintText: 'Ex : This is an important list',
                                  currentFocus: descriptionNode,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PrimaryButton(
                              teks: 'Add',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "Create new list ...",
                    style: TextStyle(
                        fontSize: 16, color: MyColor.secondaryPressed),
                  ),
                ),
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
