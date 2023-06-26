import 'package:capstone_project/model/forum_model.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:capstone_project/utils/components/empty/empty.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/forum/forum_discussion_view_model.dart';
import 'package:capstone_project/view/screen/forum/widget/forum_item_widget.dart';
import 'package:capstone_project/view/screen/forum/widget/option_sort_by_widget.dart';
import 'package:capstone_project/view/screen/forum/widget/update_forum_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/components/appbar/custom_appbar.dart';
import '../../../utils/components/buttons/floating_button.dart';
import '../../../utils/components/buttons/primary_button.dart';
import '../../../utils/components/buttons/primary_button_icon.dart';
import '../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import '../../../utils/components/text_box/regular_text_box/my_focus_node.dart';
import '../../../utils/components/text_box/search_text_box.dart';
import '../../../utils/my_color.dart';
import '../../../utils/my_size.dart';
import '../../../utils/state/finite_state.dart';

class ForumDiscussionScreen extends StatefulWidget {
  const ForumDiscussionScreen({super.key});

  static const String routeName = '/forum_discussion';

  @override
  State<ForumDiscussionScreen> createState() => _ForumDiscussionScreenState();
}

class _ForumDiscussionScreenState extends State<ForumDiscussionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _forumLinkController = TextEditingController();
  final FocusNode _forumLinkNode = FocusNode();
  final TextEditingController _forumTopicController = TextEditingController();
  final FocusNode _forumTopicNode = FocusNode();
  int? _categoryValue = 0;

  late final ForumDiscussionViewModel forumDiscussionProvider;

  @override
  void initState() {
    forumDiscussionProvider =
        Provider.of<ForumDiscussionViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      forumDiscussionProvider.fetchForum();
      forumDiscussionProvider.changeTabId(0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _forumLinkController.dispose();
    _forumLinkNode.dispose();
    _forumTopicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(
          MySize.screenWidth(context),
          double.maxFinite,
        ),
        home: false,
        judul: 'Forum Discussion',
        searchField: true,
        tabBar: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PrimaryButtonIcon(
              teks: 'New Forum',
              widget: const Icon(Icons.add),
              onPressed: () {
                if (forumDiscussionProvider.isLogin) {
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
                                DropdownSearch<TopicModel>(
                                  itemAsString: (item) => item.name!,
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    textAlign: TextAlign.left,
                                    baseStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.neutralHigh,
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
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: BorderSide(
                                          color: MyColor.neutralMediumLow,
                                          width: .25,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: BorderSide(
                                          color: MyColor.primaryMain,
                                          width: .25,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: BorderSide(
                                          color: MyColor.danger,
                                          width: .25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  items: forumDiscussionProvider.topicData,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please fill this field';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _categoryValue = value!.id;
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
                                      forumDiscussionProvider.createForum(
                                        ForumModel(
                                          categoryId: _categoryValue,
                                          topic: _forumTopicController.text,
                                          link: _forumLinkController.text,
                                        ),
                                      );
                                      forumDiscussionProvider.fetchForum();
                                      _forumLinkController.clear();
                                      _forumTopicController.clear();
                                      _categoryValue = 0;
                                      Navigator.pop(context);
                                    }
                                  },
                                  customChild:
                                      Consumer<ForumDiscussionViewModel>(
                                    builder: (context, value, _) {
                                      if (value.forumState == MyState.loading) {
                                        return const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          'Create',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: MyColor.white,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }
              },
              customHeight: 36,
              customWidth: 134,
            ),
          )
        ],
        searchTextBox: SearchTextBox(
          keyboardType: TextInputType.text,
          textEditingController: _searchController,
          onChanged: (p0) {
            forumDiscussionProvider.searchForum(p0);
          },
        ),
      ),
      body: DefaultTabController(
        length: forumDiscussionProvider.isLogin
            ? forumDiscussionProvider.topicData.length + 1
            : forumDiscussionProvider.topicData.length,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Consumer<ForumDiscussionViewModel>(
                    builder: (context, value, _) {
                      return TabBar(
                        onTap: (value) {
                          forumDiscussionProvider.changeTabId(value);
                          forumDiscussionProvider.fetchForum();
                        },
                        dividerColor: Colors.transparent,
                        isScrollable: true,
                        indicatorWeight: 1,
                        indicatorColor: MyColor.primaryMain,
                        labelColor: MyColor.primaryMain,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelColor: MyColor.neutralHigh,
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          if (value.isLogin) const Tab(text: 'my forums'),
                          ...forumDiscussionProvider.topicData
                              .map((e) => Tab(text: e.name!))
                              .toList(),
                        ],
                      );
                    },
                  )),
            ),
            Consumer<ForumDiscussionViewModel>(
              builder: (context, value, _) {
                return Container(
                  margin: const EdgeInsets.only(
                      left: MySize.screenPadding,
                      top: MySize.screenPadding,
                      bottom: MySize.screenPadding),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value.sortBy,
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.neutralMediumLow,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySize.screenPadding),
                child: Consumer<ForumDiscussionViewModel>(
                  builder: (context, value, _) {
                    final forum = value.forumData;
                    if (value.categoryId == 0) {
                      if (value.forumState == MyState.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (forum.isEmpty) {
                          return const Empty();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: forum.length,
                          itemBuilder: (context, index) {
                            return UpdateForum(forumData: forum[index]);
                          },
                        );
                      }
                    } else {
                      if (value.forumState == MyState.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (forum.isEmpty) {
                          return const Empty();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: forum.length,
                          itemBuilder: (context, index) {
                            return ForumItem(
                              forumData: forum[index],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CustomBottomSheetBuilder(
                tinggi: MediaQuery.of(context).size.height * 0.8,
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
    );
  }
}
