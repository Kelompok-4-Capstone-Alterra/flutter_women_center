import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/article/article_detail/article_detail_screen.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_post/article_list_post_view_model.dart';
import 'package:capstone_project/view/screen/article/save_content/save_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleListPostWidget extends StatelessWidget {
  final List<Articles> articles;

  const ArticleListPostWidget({Key? key, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ArticleListPostProvider>(context, listen: false);

    ReadingListModel dataReadingList = ReadingListModel();

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, ArticleDetailsScreen.routename,
                arguments: article.id);
          },
          child: Card(
            surfaceTintColor: Colors.transparent,
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    article.image ?? '',
                    width: 135,
                    height: 128,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: MyColor.danger,
                          ),
                          Text(
                            'Image Error',
                            style: TextStyle(
                              color: MyColor.danger,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          article.title ?? '',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          article.author ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.neutralMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          article.formattedDate,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: MyColor.neutralMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (provider.isLoggedIn() == true) {
                      if (provider.isArticleSaved(article.id ?? '')) {
                        provider.toggleArticleSaved(article.id ?? '');
                        await provider.removeArticleFromReadingList(
                            dataReadingList
                                .readingListArticles![index].article!.id!);
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
                                      articleId: articles[index].id ?? '',
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
                      final isArticleSaved =
                          provider.isArticleSaved(article.id ?? '');
                      return isArticleSaved
                          ? Icon(Icons.bookmark, color: MyColor.primaryMain)
                          : const Icon(Icons.bookmark_border);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
