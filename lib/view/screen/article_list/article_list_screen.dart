import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/view/screen/article_detail/article_detail_screen.dart';
import 'package:capstone_project/view/screen/article_list/bottomsheet_content.dart';
import 'package:flutter/material.dart';

class ArticleListScreen extends StatefulWidget {
  static const String routename = '/article_list_screen';
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

const List<Tab> myTabs = <Tab>[
  Tab(text: 'All'),
  Tab(text: 'Mental Health'),
  Tab(text: 'Self Improvement'),
  Tab(text: 'Spiritual'),
];

class _ArticleListScreenState extends State<ArticleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Articles",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.3,
                  ),
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Find Something here ...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            DefaultTabController(
              length: myTabs.length,
              child: const TabBar(
                isScrollable: true,
                tabs: myTabs,
                indicatorColor: Color(0xFFAF1582),
                labelColor: Color(0xFFAF1582),
                unselectedLabelColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: const Text(
                      "Most Viewed",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        final Articles articles = articlesList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailsScreen(articles: articles),
                              ),
                            );
                          },
                          child: Card(
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
                                  child: Image.asset(
                                    articles.image,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          articles.title,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          articles.author,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF6B6161),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          articles.date,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF6B6161),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 18, right: 18),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.bookmark_border),
                                      Icon(Icons.more_vert)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      itemCount: articlesList.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 130,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return const BottomSheetContent();
                });
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          backgroundColor: const Color(0xFFAF1582),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                // 3 bar icon
                Icons.sort,
                color: Colors.white,
              ),
              Text(
                'Sort By',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
