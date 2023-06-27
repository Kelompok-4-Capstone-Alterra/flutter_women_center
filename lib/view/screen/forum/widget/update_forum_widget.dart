import 'package:capstone_project/model/topic_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/forum/forum_discussion_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/forum_model.dart';
import '../../../../utils/components/buttons/outline_button.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import '../../../../utils/components/text_box/regular_text_box/my_focus_node.dart';
import '../../../../utils/my_color.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';

class UpdateForum extends StatefulWidget {
  final ForumModel forumData;
  const UpdateForum({
    super.key,
    required this.forumData,
  });

  @override
  State<UpdateForum> createState() => _UpdateForumState();
}

class _UpdateForumState extends State<UpdateForum> {
  late final ForumDiscussionViewModel forumProvider;

  @override
  void initState() {
    forumProvider =
        Provider.of<ForumDiscussionViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final day = DateTime.now()
        .difference(DateTime.parse(widget.forumData.createdAt!))
        .inDays;
    final String dateAgo = day == 0 ? 'Today' : "$day Days Ago";
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController editForumLinkController =
        TextEditingController();
    final FocusNode editForumLinkNode = FocusNode();
    final TextEditingController editForumTopicController =
        TextEditingController();
    final FocusNode editForumTopicNode = FocusNode();
    editForumTopicController.text = widget.forumData.topic!;
    editForumLinkController.text = widget.forumData.link!;
    int selectedTopic = 0;

    void updateForum() {
      Navigator.pop(context);
      forumProvider.updateForum(
        widget.forumData.id!,
        ForumModel(
          categoryId: selectedTopic,
          topic: editForumTopicController.text,
          link: editForumLinkController.text,
        ),
      );
      Navigator.pop(context);
    }

    void deleteForum() {
      Navigator.pop(context);
      forumProvider.deleteForum(
        widget.forumData.id!,
      );
      Navigator.pop(context);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.forumData.user!.picturePath!),
            ),
            title: Text(
              widget.forumData.user!.name ?? '-',
              style: TextStyle(
                fontSize: 12,
                color: MyColor.neutralHigh,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              widget.forumData.category ?? '-',
              style: TextStyle(
                fontSize: 12,
                color: MyColor.neutralMedium,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.forumData.member.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: MyColor.neutralMediumHigh,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Image.asset(
                  'assets/icons/people_outline.png',
                  width: 12,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  dateAgo,
                  style: TextStyle(
                    fontSize: 10,
                    color: MyColor.neutralMediumLow,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 224,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffDAD29C),
                        Color(0xffF9DAD9),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 88,
                  left: 53,
                  right: 53,
                  top: 88,
                  child: Text(
                    widget.forumData.topic ?? '-',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColor.neutralHigh,
                      letterSpacing: 0.15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          PrimaryButton(
            customHeight: 44,
            teks: 'Edit Forum',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return CustomBottomSheetBuilder(
                    header: true,
                    tinggi: MediaQuery.of(context).size.height * 0.80,
                    judul: 'View Forum',
                    isi: [
                      Form(
                        key: formKey,
                        child: SizedBox(
                          height: 800,
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 18, bottom: 10),
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
                                selectedItem: forumProvider.topicData
                                    .firstWhere((element) =>
                                        element.name ==
                                        widget.forumData.category),
                                dropdownDecoratorProps: DropDownDecoratorProps(
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
                                items: forumProvider.topicData,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please fill this field';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  selectedTopic = value!.id!;
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 18, bottom: 10),
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
                                textEditingController: editForumTopicController,
                                hintText:
                                    'Ex : How to improve your leadership skills',
                                onFieldSubmitted: (value) {
                                  MyFocusNode.change(
                                    context: context,
                                    currentFocus: editForumTopicNode,
                                    nextFocus: editForumLinkNode,
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
                                padding:
                                    const EdgeInsets.only(top: 18, bottom: 10),
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
                                textEditingController: editForumLinkController,
                                hintText: 'Ex : Whatsapp Group\'s Link, etc.',
                                onFieldSubmitted: (value) {
                                  MyFocusNode.change(
                                    context: context,
                                    currentFocus: editForumLinkNode,
                                    nextFocus: editForumLinkNode,
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
                                teks: 'Edit',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              const Color(0xffFFFFFF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          title: Text(
                                            'Are you sure want to make a change?',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: MyColor.neutralHigh,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            PrimaryButton(
                                              teks: 'Sure',
                                              onPressed: updateForum,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            OutlineButton(
                                              teks: 'Maybe Later',
                                              customBackgroundColor:
                                                  MyColor.white,
                                              customTextColor:
                                                  MyColor.primaryMain,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                customChild: Consumer<ForumDiscussionViewModel>(
                                  builder: (context, value, child) {
                                    if (value.forumState == MyState.loading) {
                                      return const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        'Edit',
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
                              const SizedBox(height: 16),
                              OutlineButton(
                                customBackgroundColor: MyColor.white,
                                customTextColor: MyColor.primaryMain,
                                teks: 'Delete',
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            const Color(0xffFFFFFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        title: Text(
                                          'Are you sure want to delete this forum?',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: MyColor.neutralHigh,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          PrimaryButton(
                                            teks: 'Sure',
                                            onPressed: deleteForum,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          OutlineButton(
                                            teks: 'Maybe Later',
                                            customBackgroundColor:
                                                MyColor.white,
                                            customTextColor:
                                                MyColor.primaryMain,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                customChild: Consumer<ForumDiscussionViewModel>(
                                  builder: (context, value, child) {
                                    if (value.forumState == MyState.loading) {
                                      return const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor.primaryMain,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
