import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../join_forum_discussion_view_model.dart';

class OptionSortBy extends StatelessWidget {
  const OptionSortBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SortByForumProvider>(
      builder: (context, radioModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  radioModel.setSelectedOption('Option 1');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most Viewed',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 16,
                      height: 14,
                      child: radioModel.selectedOption == 'Option 1'
                          ? Icon(
                              Icons.check,
                              color: MyColor.primaryMain,
                              size: 16,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              InkWell(
                onTap: () {
                  radioModel.setSelectedOption('Option 2');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Newest Viewed',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 16,
                      height: 14,
                      child: radioModel.selectedOption == 'Option 2'
                          ? Icon(
                              Icons.check,
                              color: MyColor.primaryMain,
                              size: 16,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              InkWell(
                onTap: () {
                  radioModel.setSelectedOption('Option 3');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Oldest',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 16,
                      height: 14,
                      child: radioModel.selectedOption == 'Option 3'
                          ? Icon(
                              Icons.check,
                              color: MyColor.primaryMain,
                              size: 16,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              PrimaryButton(
                teks: 'Save',
                onPressed: () {
                  Navigator.pop(context);
                  debugPrint('Pilihan: ${radioModel.selectedOption}');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
