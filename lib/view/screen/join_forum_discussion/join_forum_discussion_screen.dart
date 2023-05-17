import 'package:flutter/material.dart';

class JoinForumDiscussionScreen extends StatefulWidget {
  static const String routeName = '/Join_forum_discussion_screen';

  const JoinForumDiscussionScreen({super.key});

  @override
  State<JoinForumDiscussionScreen> createState() =>
      _JoinForumDiscussionScreenState();
}

class _JoinForumDiscussionScreenState extends State<JoinForumDiscussionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forum Discussion',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          Container(
            height: 36,
            width: 134,
            margin: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 16,
            ),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Find Something here ...',
                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(0xff9E9494),
                      ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            //! lanjut disini bikin tabbar widget
          ],
        ),
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
