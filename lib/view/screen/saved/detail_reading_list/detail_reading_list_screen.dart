import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_screen.dart';
import 'package:capstone_project/view/screen/saved/widgets/article_list_popup_menu_button.dart';
import 'package:capstone_project/view/screen/saved/widgets/horizontal_article_card.dart';
import 'package:capstone_project/view/screen/saved/widgets/vertical_article_card.dart';
import 'package:flutter/material.dart';

class DetailReadingListScreen extends StatefulWidget {
  const DetailReadingListScreen({super.key});

  static const String routeName = '/detail_reading_list_screen';

  @override
  State<DetailReadingListScreen> createState() =>
      _DetailReadingListScreenState();
}

class _DetailReadingListScreenState extends State<DetailReadingListScreen> {
  final TextEditingController _editListNameController = TextEditingController();
  final TextEditingController _editDescriptionController =
      TextEditingController();
  final FocusNode _editListNameNode = FocusNode();
  final FocusNode _editDescriptionNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Reading List',
        home: false,
        searchField: true,
        tabBar: false,
        actions: [
          ArticleListPopupMenuButton(
            editListNameTextEditingController: _editListNameController,
            editDescriptionTextEditingController: _editDescriptionController,
            editListNameFocusNode: _editListNameNode,
            editDescriptionFocusNode: _editDescriptionNode,
          )
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'List\'s Name',
      //         style: TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.w500,
      //           color: MyColor.primaryMain,
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //       SizedBox(
      //         height: 40,
      //         width: double.infinity,
      //         child: Row(
      //           children: [
      //             const CircleAvatar(
      //               radius: 20,
      //               backgroundImage: NetworkImage(
      //                   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
      //             ),
      //             const SizedBox(width: 16),
      //             SizedBox(
      //               height: double.infinity,
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     'John Doe',
      //                     style: TextStyle(
      //                       fontSize: 12,
      //                       fontWeight: FontWeight.w500,
      //                       color: MyColor.neutralHigh,
      //                     ),
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         '2 Articles',
      //                         style: TextStyle(
      //                           fontSize: 11,
      //                           fontWeight: FontWeight.w500,
      //                           color: MyColor.neutralHigh,
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         width: 8,
      //                       ),
      //                       Text(
      //                         '2 days ago',
      //                         style: TextStyle(
      //                           fontSize: 11,
      //                           fontWeight: FontWeight.w500,
      //                           color: MyColor.neutralMediumLow,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List\'s Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MyColor.primaryMain,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColor.neutralHigh,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '2 Articles',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: MyColor.neutralHigh,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '2 days ago',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: MyColor.neutralMediumLow,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ArticleScreen.routeName);
                    },
                    child: const VerticalArticleCard(),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
