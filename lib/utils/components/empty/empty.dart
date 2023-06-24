import 'package:flutter/material.dart';
import '../../my_color.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/nothing_here.png'),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Woops! Sorry, no result found.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: MyColor.neutralHigh,
            ),
          ),
        ],
      ),
    );
  }
}
