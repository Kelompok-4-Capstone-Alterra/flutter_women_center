import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../utils/components/buttons/outline_button.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_focus_node.dart';

class EditForumPostWidget extends StatelessWidget {
  EditForumPostWidget({super.key});

  final TextEditingController _editForumLinkController =
      TextEditingController();

  final FocusNode _editForumLinkNode = FocusNode();
  final TextEditingController _editForumTopicController =
      TextEditingController();

  final FocusNode _editForumTopicNode = FocusNode();
  final List<String> _itemsOptionSortBy = const [
    "Women's Right",
    'Mental Health',
    'Career Supportive',
    'Self Development',
    'Healthy Relationship',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Newest',
              style: TextStyle(
                fontSize: 12,
                color: MyColor.neutralMediumLow,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200'),
                      ),
                      title: Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 12,
                          color: MyColor.neutralHigh,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Self Development',
                        style: TextStyle(
                          fontSize: 8,
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
                            '5000',
                            style: TextStyle(
                              fontSize: 8,
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
                            '2 Days Ago',
                            style: TextStyle(
                              fontSize: 8,
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
                              'Do your ever have a bad experience for being a women?',
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
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            hintText:
                                                'Choose topic\'s category',
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
                                        textEditingController:
                                            _editForumTopicController,
                                        hintText:
                                            'Ex : How to improve your leadership skills',
                                        onFieldSubmitted: (value) {
                                          MyFocusNode.change(
                                            context: context,
                                            currentFocus: _editForumTopicNode,
                                            nextFocus: _editForumLinkNode,
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
                                        textEditingController:
                                            _editForumLinkController,
                                        hintText:
                                            'Ex : Whatsapp Group\'s Link, etc.',
                                        onFieldSubmitted: (value) {
                                          MyFocusNode.change(
                                            context: context,
                                            currentFocus: _editForumLinkNode,
                                            nextFocus: _editForumLinkNode,
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      const Color(0xffFFFFFF),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  title: Text(
                                                    'Are you sure want to make a change?',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          MyColor.neutralHigh,
                                                      letterSpacing: 0.1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    PrimaryButton(
                                                      teks: 'Sure',
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
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
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
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
                                      )
                                    ],
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
            },
          ),
        ],
      ),
    );
  }
}
