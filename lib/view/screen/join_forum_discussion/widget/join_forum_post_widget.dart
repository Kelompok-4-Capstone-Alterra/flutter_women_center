
import 'package:flutter/material.dart';

import '../../../../utils/components/buttons/primary_button.dart';
import '../../home/home_screen.dart';

class JoinForumPostWidget extends StatefulWidget {
  const JoinForumPostWidget({super.key});

  @override
  State<JoinForumPostWidget> createState() => _JoinForumPostWidgetState();
}

class _JoinForumPostWidgetState extends State<JoinForumPostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Newest',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const PostContentWidget(),
          const PostContentWidget(),
          const PostContentWidget(),
          const PostContentWidget(),
        ],
      ),
    );
  }
}

class PostContentWidget extends StatelessWidget {
  const PostContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Bad Experience',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Text(
                    '2 Days Ago',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Image.network(
                  'https://picsum.photos/300',
                  height: 224,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  color: Colors.black12.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                ),
                Positioned.fill(
                  bottom: 88,
                  left: 53,
                  right: 53,
                  top: 88,
                  child: Text(
                    'Do your ever have a bad experience for being a women?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
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
            teks: 'Join Forum',
            onPressed: () {
              //! ganti ini ke detail forum discussion
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
