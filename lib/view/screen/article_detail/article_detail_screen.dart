import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/article_detail/comment_content.dart';
import 'package:capstone_project/view/screen/article_detail/save_content.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  static const String routename = '/article_details_screen';

  final Articles articles;
  const ArticleDetailsScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        home: false,
        title: 'Articles',
        action: false,
        searchField: false,
        tabBar: false,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return const CommentContent();
                        });
                  },
                  icon: const Icon(Icons.comment),
                ),
                const SizedBox(
                  width: 20,
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SaveContent();
                                  });
                            },
                            child: Text(
                              'Save to ...',
                              style: TextStyle(color: MyColor.neutralHigh),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Show less like this',
                                style: TextStyle(color: MyColor.neutralHigh),
                              ))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Report",
                              style: TextStyle(
                                color: MyColor.danger,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    articles.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    articles.date,
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.neutralMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Kategori Artikel (Mental Health)',
                style: TextStyle(
                    fontSize: 14,
                    color: MyColor.neutralMedium,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                articles.author,
                style: TextStyle(
                    fontSize: 14,
                    color: MyColor.neutralMedium,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Image.asset(articles.image),
              const SizedBox(
                height: 16,
              ),
              Text(
                articles.desc,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
