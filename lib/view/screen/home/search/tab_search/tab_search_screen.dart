import 'package:flutter/material.dart';

import '../../../../../utils/my_color.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                onTap: (value) {},
                dividerColor: Colors.transparent,
                isScrollable: true,
                indicatorWeight: 1,
                indicatorColor: MyColor.primaryMain,
                labelColor: MyColor.primaryMain,
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                tabs: const [
                  Tab(
                    text: 'Article',
                  ),
                  Tab(
                    text: 'Counseling',
                  ),
                  Tab(
                    text: 'Career',
                  ),
                  Tab(
                    text: 'Forum Discussion',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
