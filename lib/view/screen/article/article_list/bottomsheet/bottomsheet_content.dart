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
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white),
        child: Transform.scale(
          scaleX: 1.1,
          scaleY: 1.1,
          child: Column(
            children: [
              Consumer<ArticleListProvider>(builder: (context, provider, _) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (provider.isLoggedIn() == true) {
                          provider.sortArticles('most_viewed');
                        } else {
                          provider.sortArticlesNoLogin('most_viewed');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Most Viewed'),
                          (provider.sortValues == 'most_viewed')
                              ? Icon(Icons.check, color: MyColor.primaryMain)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () {
                        if (provider.isLoggedIn() == true) {
                          provider.sortArticles('newest');
                        } else {
                          provider.sortArticlesNoLogin('newest');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Newest'),
                          (provider.sortValues == 'newest')
                              ? Icon(Icons.check, color: MyColor.primaryMain)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () {
                        if (provider.isLoggedIn() == true) {
                          provider.sortArticles('oldest');
                        } else {
                          provider.sortArticlesNoLogin('oldest');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Oldest'),
                          (provider.sortValues == 'oldest')
                              ? Icon(Icons.check, color: MyColor.primaryMain)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
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
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
