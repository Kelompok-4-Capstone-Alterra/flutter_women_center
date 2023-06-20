import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/article/article_detail/article_detail_screen.dart';
import 'package:capstone_project/view/screen/article/widget/save_content.dart';
import 'package:capstone_project/view/screen/article/widget/save_content_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleListPostWidget extends StatelessWidget {
  final List<Articles> articles;

  const ArticleListPostWidget({Key? key, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SaveContentProvider>(context, listen: false);

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
                  onPressed: () {
                    if (provider.isArticleSaved(article.id ?? '')) {
                      provider.toggleArticleSaved(article.id ?? '');
                      provider.removeArticleFromReadingList(article.id ?? '');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from reading list'),
                        ),
                      );
                    } else {
                      provider.toggleArticleSaved(article.id ?? '');
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
                  },
                  icon: Consumer<SaveContentProvider>(
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
