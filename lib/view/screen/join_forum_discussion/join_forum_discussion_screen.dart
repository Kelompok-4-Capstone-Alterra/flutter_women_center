import 'package:capstone_project/view/screen/join_forum_discussion/widget/content_widget.dart';
import 'package:flutter/material.dart';

class JoinForumDiscussionScreen extends StatefulWidget {
  static const String routeName = '/Join_forum_discussion_screen';

  const JoinForumDiscussionScreen({super.key});

  @override
  State<JoinForumDiscussionScreen> createState() =>
      _JoinForumDiscussionScreenState();
}

class _JoinForumDiscussionScreenState extends State<JoinForumDiscussionScreen> {
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
        appBar: AppBar(
          title: Text(
            'Forum Discussion',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 36,
                width: 134,
                decoration: const BoxDecoration(
                  color: Color(0xFFAF1582),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    bottomSheetScreen(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        'New Forum',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.25,
            ),
            child: Material(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find Something here ...',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: const Color(0xff9E9494),
                                ),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xffE7E4E4),
                    thickness: 1,
                  ),
                  TabBar(
                    isScrollable: true,
                    tabs: _tabs,
                    indicatorColor: const Color(0xFFAF1582),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ContentWidget();
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ContentWidget();
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ContentWidget();
              },
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ContentWidget();
              },
            ),
          ],
        ),
        floatingActionButton: InkWell(
          onTap: () {
            bottomSheetScreen(context);
          },
          child: Container(
            height: 50,
            width: 130,
            margin: const EdgeInsets.only(
              bottom: 35,
              right: 125,
              left: 125,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFAF1582),
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  // 3 bar icon
                  Icons.sort,
                  color: Colors.white,
                ),
                Text(
                  'Sort By',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetScreen(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sort By',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
