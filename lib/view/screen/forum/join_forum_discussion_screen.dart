import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/view/screen/forum/widget/edit_forum_post_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../utils/components/appbar/custom_appbar.dart';
import '../../../utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import '../../../utils/components/buttons/floating_button.dart';

import '../../../utils/components/buttons/primary_button.dart';
import '../../../utils/components/buttons/primary_button_icon.dart';

import '../../../utils/components/text_box/regular_text_box/my_focus_node.dart';
import '../../../utils/components/text_box/search_text_box.dart';
import '../../../utils/my_color.dart';
import '../../../utils/my_size.dart';
import 'widget/join_forum_post_widget.dart';
import 'widget/option_sort_by_widget.dart';

class JoinForumDiscussionScreen extends StatefulWidget {
  const JoinForumDiscussionScreen({super.key});

  static const String routeName = '/Join_forum_discussion_screen';

  @override
  State<JoinForumDiscussionScreen> createState() =>
      _JoinForumDiscussionScreenState();
}

class _JoinForumDiscussionScreenState extends State<JoinForumDiscussionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _forumLinkController = TextEditingController();
  final FocusNode _forumLinkNode = FocusNode();
  final TextEditingController _forumTopicController = TextEditingController();
  final FocusNode _forumTopicNode = FocusNode();
  final List<String> _itemsOptionSortBy = const [
    "Women's Right",
    'Mental Health',
    'Career Supportive',
    'Self Development',
    'Healthy Relationship',
  ];

  final List<Tab> _tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'My Forum',
    ),
    const Tab(
      text: 'Women\'s Right',
    ),
    const Tab(
      text: 'Self Development',
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
          home: false,
          judul: 'Forum Discussion',
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
                    builder: (context) {
                      return CustomBottomSheetBuilder(
                        header: true,
                        tinggi: MediaQuery.of(context).size.height * 0.80,
                        judul: 'Create New Forum',
                        isi: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18, bottom: 10),
                                  child: Text(
                                    'Topic\'s Category',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyColor.neutralHigh,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
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
                                      hintText: 'Choose topic\'s category',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      isDense: true,
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: MyColor.neutralMediumLow,
                                      ),
                                    ),
                                  ),
                                  items: _itemsOptionSortBy,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill this field';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    debugPrint(value);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18, bottom: 10),
                                  child: Text(
                                    'Forum\'s Topic',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyColor.neutralHigh,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                TextBox(
                                  textEditingController: _forumTopicController,
                                  hintText:
                                      'Ex : How to improve your leadership skills',
                                  onFieldSubmitted: (value) {
                                    MyFocusNode.change(
                                      context: context,
                                      currentFocus: _forumTopicNode,
                                      nextFocus: _forumLinkNode,
                                    );
                                  },
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'Please fill this field';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18, bottom: 10),
                                  child: Text(
                                    'Forum\'s Link',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyColor.neutralHigh,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                TextBox(
                                  textEditingController: _forumLinkController,
                                  hintText: 'Ex : Whatsapp Group\'s Link, etc.',
                                  onFieldSubmitted: (value) {
                                    MyFocusNode.change(
                                      context: context,
                                      currentFocus: _forumLinkNode,
                                      nextFocus: _forumLinkNode,
                                    );
                                  },
                                  validator: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'Please fill this field';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                PrimaryButton(
                                  teks: 'Create',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
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
            keyboardType: TextInputType.text,
            textEditingController: _searchController,
          ),
        ),
        body: TabBarView(
          children: [
            const JoinForumPostWidget(),
            EditForumPostWidget(),
            const JoinForumPostWidget(),
            const JoinForumPostWidget(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return CustomBottomSheetBuilder(
                  tinggi: MediaQuery.of(context).size.height * 0.80,
                  header: true,
                  judul: 'Sort By',
                  isi: const [
                    OptionSortBy(),
                  ],
                );
              },
            );
          },
          teks: 'Sort By',
          widget: const Icon(Icons.sort),
        ),
        bottomNavigationBar: const BottomNavBar(
          currentIndex: 0,
        ),
      ),
    );
  }
}
