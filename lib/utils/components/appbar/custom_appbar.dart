import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';
import '../text_box/search_text_box.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool action;
  final bool searchField;
  final bool tabBar;
  final bool home;
  final List<Widget>? actions;
  final List<Widget>? tabs;
  final SearchTextBox? searchTextBox;

  const CustomAppBar({
    super.key,
    required this.preferredSize,
    required this.home,
    required this.action,
    required this.searchField,
    required this.tabBar,
    this.searchTextBox,
    this.actions,
    this.tabs,
  });

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    late double height;
    if (home == true) {
      height = 206;
    } else {
      if (searchField == true && tabBar == false) {
        height = 178;
      } else if (searchField == false && tabBar == true) {
        height = 174;
      } else if (searchField == true && tabBar == true) {
        height = 238;
      } else {
        height = 114;
      }
    }
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 42,
          ),
          AppBar(
            toolbarHeight: 40,
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColor.neutralHigh,
              ),
            ),
            actions: actions,
          ),
          home == true
              ? Padding(
                  padding: const EdgeInsets.only(left: MySize.screenPadding),
                  child: Text(
                    'Hi,SUser!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColor.secondaryMain,
                    ),
                  ),
                )
              : const SizedBox(),
          searchField == true
              ? const SizedBox(
                  height: 16,
                )
              : const SizedBox(),
          home == true
              ? const SizedBox(
                  height: 24,
                )
              : const SizedBox(),
          searchField == true || home == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: searchTextBox)
              : const SizedBox(),
          const SizedBox(
            height: 31,
          ),
          Divider(
            height: 1,
            color: MyColor.neutralLow,
            thickness: .5,
          ),
          tabBar == true
              ? SizedBox(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      indicatorWeight: 1,
                      indicatorColor: MyColor.primaryMain,
                      labelColor: MyColor.primaryMain,
                      labelPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelColor: MyColor.neutralHigh,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: tabs!,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
