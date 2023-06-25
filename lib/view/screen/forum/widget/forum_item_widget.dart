import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/forum/forum_discussion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/forum_model.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/my_color.dart';

class ForumItem extends StatelessWidget {
  final ForumModel forumData;
  const ForumItem({
    super.key,
    required this.forumData,
  });

  @override
  Widget build(BuildContext context) {
    final day =
        DateTime.now().difference(DateTime.parse(forumData.createdAt!)).inDays;
    final String dateAgo = day == 0 ? 'Today' : "$day Days Ago";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(forumData.user!.picturePath!),
            ),
            title: Text(
              forumData.user!.name ?? '-',
              style: TextStyle(
                fontSize: 12,
                color: MyColor.neutralHigh,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              forumData.category ?? '-',
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
                  forumData.member.toString(),
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
                    forumData.topic ?? '-',
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColor.neutralHigh,
                      letterSpacing: 0.15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
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
            teks: 'Join Forum',
            onPressed: () async {
              final forumProvider =
                  Provider.of<ForumDiscussionViewModel>(context, listen: false);
              if (forumProvider.isLogin) {
                forumProvider.joinForum(forumData.id!);
                forumProvider.launchForum(forumData.link!);
              } else {
                Navigator.pushNamed(context, LoginScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
    ;
  }
}
