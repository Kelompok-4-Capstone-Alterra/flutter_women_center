import 'package:capstone_project/utils/components/text_box/text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/join_forum_discussion/widget/join_forum_post_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../utils/components/appbar/custom_appbar.dart';
import '../../../utils/components/buttons/floating_button.dart';
import '../../../utils/components/buttons/primary_button.dart';
import '../../../utils/components/buttons/primary_button_icon.dart';

import '../../../utils/components/text_box/search_text_box.dart';
import '../../../utils/my_focus_node.dart';
import '../../../utils/my_size.dart';
import 'widget/option_sort_by_widget.dart';

class JoinForumDiscussionScreen extends StatefulWidget {
  static const String routeName = '/Join_forum_discussion_screen';

  const JoinForumDiscussionScreen({super.key});

  @override
  State<JoinForumDiscussionScreen> createState() =>
      _JoinForumDiscussionScreenState();
}

class _JoinForumDiscussionScreenState extends State<JoinForumDiscussionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _topicCategoryController =
      TextEditingController();
  final TextEditingController _forumTopicController = TextEditingController();
  final TextEditingController _forumLinkController = TextEditingController();
  final FocusNode _topicCategoryNode = FocusNode();
  final FocusNode _forumTopicNode = FocusNode();
  final FocusNode _forumLinkNode = FocusNode();
  final List<Tab> _tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'Sexual Harassment',
    ),
    const Tab(
      text: 'Bad Experience',
    ),
    const Tab(
      text: 'Career Improvement',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _tabs.length,
      child: Scaffold(
        appBar: CustomAppBar(
          preferredSize: Size(
            MySize.screenWidth(context),
            double.maxFinite,
          ),
          title: 'Forum Discussion',
          home: false,
          action: false,
          searchField: true,
          tabBar: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PrimaryButtonIcon(
                teks: 'New Forum',
                widget: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 24,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Create New Forum',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18, bottom: 10),
                                    child: Text(
                                      "Topic's Category",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColor.neutralHigh,
                                          ),
                                    ),
                                  ),
                                  // TextBox(
                                  //   textEditingController:
                                  //       _topicCategoryController,
                                  //   hintText: "Choose topic's category",
                                  //   onFieldSubmitted: (value) {
                                  //     MyFocusNode.change(
                                  //       context: context,
                                  //       currentFocus: _topicCategoryNode,
                                  //       nextFocus: _forumTopicNode,
                                  //     );
                                  //   },
                                  // ),
                                  DropdownSearch<String>(
                                    popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                    ),
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      textAlign: TextAlign.left,
                                      baseStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: MyColor.neutralMediumLow,
                                      ),
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: "Choose topic's category",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        isDense: true,
                                        hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.neutralMediumLow,
                                        ),
                                      ),
                                    ),
                                    items: const [
                                      "Women's Right",
                                      'Mental Health',
                                      'Career Supportive',
                                      'Self Development',
                                      'Healthy Relationship',
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18, bottom: 10),
                                    child: Text(
                                      "Forum's Topic",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColor.neutralHigh,
                                          ),
                                    ),
                                  ),
                                  TextBox(
                                    textEditingController:
                                        _forumTopicController,
                                    hintText:
                                        "Ex : How to improve your leadership skills",
                                    onFieldSubmitted: (value) {
                                      MyFocusNode.change(
                                        context: context,
                                        currentFocus: _forumTopicNode,
                                        nextFocus: _forumLinkNode,
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18, bottom: 10),
                                    child: Text(
                                      "Forum's Link",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColor.neutralHigh,
                                          ),
                                    ),
                                  ),
                                  TextBox(
                                    textEditingController: _forumLinkController,
                                    hintText:
                                        "Ex : Whatsapp Group's Link, etc.",
                                    onFieldSubmitted: (value) {
                                      MyFocusNode.change(
                                        context: context,
                                        currentFocus: _forumLinkNode,
                                        nextFocus: _forumLinkNode,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  PrimaryButton(
                                    teks: 'Done',
                                    onPressed: () {
                                      _forumTopicController.clear();
                                      _forumLinkController.clear();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                customHeight: 36,
                customWidth: 134,
              ),
            )
          ],
          tabs: _tabs,
          searchTextBox: SearchTextBox(
            textEditingController: _searchController,
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const JoinForumPostWidget();
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const JoinForumPostWidget();
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const JoinForumPostWidget();
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const JoinForumPostWidget();
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 24,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sort By',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      const OptionSortBy(),
                    ],
                  ),
                );
              },
            );
          },
          teks: 'Sort By',
          widget: const Icon(Icons.sort),
        ),
      ),
    );
  }
}
