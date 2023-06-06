import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';

import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/article/article_detail/widget/comment_content.dart';
import 'package:capstone_project/view/screen/article/widget/save_content.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  static const String routename = '/article_details_screen';
  final Articles articles;

  const ArticleDetailsScreen({Key? key, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        home: false,
        judul: 'Articles',
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
                        useRootNavigator: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(
                            children: [
                              CustomBottomSheetBuilder(
                                tinggi:
                                    MediaQuery.of(context).size.height * 0.9,
                                isi: const [
                                  CommentContent(),
                                ],
                                header: true,
                                judul: 'Comments',
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.comment),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(children: const [SaveContent()]);
                        });
                  },
                  icon: const Icon(Icons.bookmark_border),
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
