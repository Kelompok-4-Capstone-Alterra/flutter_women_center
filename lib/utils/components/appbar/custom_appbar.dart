import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';
import '../text_box/search_text_box.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool searchField;

  final String judul;
  final bool tabBar;
  final bool home;
  final List<Widget>? actions;
  final List<Widget>? tabs;
  final SearchTextBox? searchTextBox;
  final Widget? homeText;

  const CustomAppBar({
    super.key,
    required this.preferredSize,
    required this.judul,
    required this.home,
    required this.searchField,
    required this.tabBar,
    this.searchTextBox,
    this.actions,
    this.tabs,
    this.homeText,
  });

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            scrolledUnderElevation: 0,
            toolbarHeight: 40,
            title: Text(
              judul,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColor.neutralHigh,
              ),
            ),
            actions: actions,
          ),
          home == true ? homeText ?? const SizedBox() : const SizedBox(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
