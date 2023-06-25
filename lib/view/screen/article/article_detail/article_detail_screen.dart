import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';

import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/article/article_detail/article_detail_view_model.dart';
import 'package:capstone_project/view/screen/article/article_detail/comment/comment_content.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_post/article_list_post_view_model.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_view_model.dart';
import 'package:capstone_project/view/screen/article/save_content/save_content.dart';
import 'package:capstone_project/view/screen/article/save_content/save_content_view_model.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

import 'package:provider/provider.dart';

class ArticleDetailsScreen extends StatelessWidget {
  static const String routename = '/article_details_screen';

  const ArticleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleId = ModalRoute.of(context)!.settings.arguments as String;
    final provider =
        Provider.of<ArticleListPostProvider>(context, listen: false);

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
                    if (provider.isLoggedIn() == true) {
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
                                  isi: [
                                    CommentContent(
                                      articleId: articleId,
                                    ),
                                  ],
                                  header: true,
                                  judul: 'Comments',
                                ),
                              ],
                            );
                          });
                    } else {
                      Navigator.pushNamed(context, '/login_screen');
                    }
                  },
                  icon: const Icon(Icons.comment),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () async {
                    if (provider.isLoggedIn() == true) {
                      final saved = provider.isArticleSaved(articleId);
                      if (saved) {
                        provider.toggleArticleSaved(articleId, false);
                        final detailProvider =
                            Provider.of<SavedViewModel>(context, listen: false);
                        final data = detailProvider.allReadingListData;
                        String result = '';

                        for (var detail in data) {
                          for (var sangatDetail
                              in detail.readingListArticles!) {
                            if (sangatDetail.article!.id == articleId) {
                              result = sangatDetail.id ?? '';
                            }
                          }
                        }
                        provider.removeArticleFromReadingList(result);
                        detailProvider.showAllReadingList();
                      } else {
                        showModalBottomSheet(
                          useRootNavigator: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Wrap(
                              children: [
                                CustomBottomSheetBuilder(
                                  tinggi:
                                      MediaQuery.of(context).size.height * 0.8,
                                  isi: [
                                    SaveContent(
                                      articleId: articleId,
                                    ),
                                  ],
                                  header: true,
                                  judul: 'Save to...',
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      Navigator.pushNamed(context, '/login_screen');
                    }
                  },
                  icon: Consumer<ArticleListPostProvider>(
                    builder: (context, provider, _) {
                      final isArticleSaved = provider.isArticleSaved(articleId);
                      return isArticleSaved
                          ? Icon(Icons.bookmark, color: MyColor.primaryMain)
                          : const Icon(Icons.bookmark_border);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Consumer<ArticleListProvider>(builder: (context, provider, _) {
        final articles = provider.getArticleById(articleId);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      articles!.title ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      articles.formattedDate,
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
                  articles.topic!.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColor.neutralMedium,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  articles.author ?? '',
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColor.neutralMedium,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.network(
                  articles.image ?? '',
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 16,
                ),
                HtmlWidget(articles.description ?? '')
              ],
            ),
          ),
        );
      }),
    );
  }
}
