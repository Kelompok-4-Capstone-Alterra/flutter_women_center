import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Transform.scale(
            scaleX: 1.1,
            scaleY: 1.1,
            child: Column(
              children: [
                Consumer<ArticleListProvider>(
                  builder: ((context, provider, child) {
                    final selectedSortBy = provider.selectedSortBy;

                    return Column(
                      children: [
                        CheckboxListTile(
                          activeColor: Colors.white,
                          checkColor: MyColor.primaryMain,
                          value: selectedSortBy == SortBy.mostViewed,
                          title: const Text("Most Viewed"),
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (bool? value) {
                            if (value != null && value) {
                              provider.setSelectedSortBy = SortBy.mostViewed;
                              provider.setSelectedText = 'Most Viewed';
                            }
                          },
                        ),
                        CheckboxListTile(
                          activeColor: Colors.white,
                          checkColor: MyColor.primaryMain,
                          value: selectedSortBy == SortBy.newest,
                          title: const Text("Newest"),
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (bool? value) {
                            if (value != null && value) {
                              provider.setSelectedSortBy = SortBy.newest;
                              provider.setSelectedText = 'Newest';
                            }
                          },
                        ),
                        CheckboxListTile(
                          activeColor: Colors.white,
                          checkColor: MyColor.primaryMain,
                          value: selectedSortBy == SortBy.older,
                          title: const Text("Older"),
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (bool? value) {
                            if (value != null && value) {
                              provider.setSelectedSortBy = SortBy.older;
                              provider.setSelectedText = 'Older';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            height: 44,
                            width: double.infinity,
                            child: PrimaryButton(
                              teks: 'Save',
                              onPressed: () {
                                provider.setSelectedSortBy =
                                    provider.selectedSortBy;
                                provider.setSelectedText =
                                    provider.selectedText;
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
