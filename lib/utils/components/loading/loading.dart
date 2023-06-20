import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyColor.white,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: MyColor.neutralMediumLow,
          width: .25,
        ),
      ),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: MyColor.primaryMain,
                strokeWidth: 2,
              ),
              const SizedBox(
                width: 50,
              ),
              const Text('Loading . . .'),
            ],
          ),
        ),
      ),
    );
  }
}
