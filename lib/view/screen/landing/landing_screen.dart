import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onboarding/onboarding_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static const routeName = '/landing_screen';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    Provider.of<LandingViewModel>(context, listen: false).checkFirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingViewModel>(
      builder: (context, value, _) {
        if (value.isFistTime) {
          return const OnboardingScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
