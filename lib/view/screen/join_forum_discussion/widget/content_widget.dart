import 'package:flutter/material.dart';

import '../../home/home_screen.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
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
            child: Image.network(
              'https://picsum.photos/300',
              height: 224,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              //! ganti ini ke detail forum discussion
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFAF1582),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  'Join Forum',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
