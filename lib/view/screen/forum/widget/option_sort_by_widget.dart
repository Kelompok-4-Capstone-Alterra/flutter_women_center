import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../forum_discussion_view_model.dart';
import 'option_sord_by_view_model.dart';

class OptionSortBy extends StatelessWidget {
  const OptionSortBy({super.key});

  @override
  Widget build(BuildContext context) {
    final forumProvider =
        Provider.of<ForumDiscussionViewModel>(context, listen: false);
    return Consumer<OptionSortByViewModel>(
      builder: (context, radioModel, child) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                radioModel.setSelectedSortBy('Popular');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.neutralHigh,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: 18,
                    height: 16,
                    child: radioModel.selectedSortBy == 'Popular'
                        ? Icon(
                            Icons.check,
                            color: MyColor.primaryMain,
                            size: 18,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            InkWell(
              onTap: () {
                radioModel.setSelectedSortBy('Newest');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Newest',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.neutralHigh,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: 18,
                    height: 16,
                    child: radioModel.selectedSortBy == 'Newest'
                        ? Icon(
                            Icons.check,
                            color: MyColor.primaryMain,
                            size: 18,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            InkWell(
              onTap: () {
                radioModel.setSelectedSortBy('Oldest');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Oldest',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.neutralHigh,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: 18,
                    height: 16,
                    child: radioModel.selectedSortBy == 'Oldest'
                        ? Icon(
                            Icons.check,
                            color: MyColor.primaryMain,
                            size: 18,
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
                if (radioModel.selectedSortBy != null) {
                  forumProvider
                      .changeSortBy(radioModel.selectedSortBy!.toLowerCase());
                  forumProvider.fetchForum();
                  Navigator.pop(context);
                } else if (radioModel.selectedSortBy == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please select one of the options'),
                      backgroundColor: MyColor.primaryMain,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
