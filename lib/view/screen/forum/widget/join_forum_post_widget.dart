import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/my_color.dart';
import '../join_forum_discussion_view_model.dart';

class JoinForumPostWidget extends StatelessWidget {
  const JoinForumPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JoinForumDiscussionViewModel>(
      builder: (context, joinForum, child) {
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
                  'Popular',
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
                    padding:
                        const EdgeInsets.only(top: 24, left: 16, right: 16),
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
                                  'How to Improve your Personal Productivity and Time Management',
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
                            await joinForum
                                .joinForum('https://t.me/+IvnMwARJVvo3Mzll');
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
      },
    );
  }
}
