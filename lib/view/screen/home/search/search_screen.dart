import 'package:flutter/material.dart';

import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/text_box/search_text_box.dart';
import '../../../../utils/my_size.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        home: false,
        searchField: true,
        tabBar: false,
        judul: 'Search',
        searchTextBox: SearchTextBox(
          textEditingController: searchController,
        ),
      ),
    );
  }
}
