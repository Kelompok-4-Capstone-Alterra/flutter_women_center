import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_screen.dart';
import 'package:capstone_project/view/screen/onboarding/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = '/onboarding_screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final onboardingProvider =
        Provider.of<OnboardingViewModel>(context, listen: false);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          bottom: MediaQuery.of(context).size.height * 0.2,
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) {
            if (page == 2) {
              onboardingProvider.setIsLastPage(true);
            } else {
              onboardingProvider.setIsLastPage(false);
            }
          },
          children: [
            // onboarding 1
            Padding(
              padding: const EdgeInsets.only(
                  left: MySize.screenPadding, right: MySize.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image:
                        const AssetImage('assets/images/customer_support.png'),
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'Hello ! Welcome to Women Center.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    'We are excited to welcome you to Women Center, a safe and supportive space for women of all ages and backgrounds. Our center provides a variety of services and resources to help empower and uplift women in our community.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                ],
              ),
            ),
            // onboarding 2
            Padding(
              padding: const EdgeInsets.only(
                  left: MySize.screenPadding, right: MySize.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image:
                        const AssetImage('assets/images/customer_support.png'),
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'At Women Center you will find',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    'Counseling and support groups to address a range of issues, from mental health to relationship concerns. Also career and educational resources to help women achieve their professional goals.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                ],
              ),
            ),
            // thnk you screen
            Padding(
              padding: const EdgeInsets.only(
                  left: MySize.screenPadding, right: MySize.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage('assets/images/thank_you.png'),
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'Lets join with us!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "Don't let the challenges of being a woman hold you back. Join us at our Women's Center and start your journey towards empowerment and success today.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: MyColor.white,
        padding: const EdgeInsets.only(
          left: MySize.screenPadding,
          right: MySize.screenPadding,
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Consumer<OnboardingViewModel>(
          builder: (context, value, _) {
            if (value.isLastPage) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    teks: 'Back',
                    onPressed: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    customWidth: MediaQuery.of(context).size.width * 0.45,
                    customBackgroundColor: MyColor.white,
                    customTextColor: MyColor.secondaryMain,
                  ),
                  PrimaryButton(
                    teks: 'Get Started',
                    onPressed: () {
                      onboardingProvider.appStarted();
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                    },
                    customWidth: MediaQuery.of(context).size.width * 0.45,
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    teks: 'Skip',
                    onPressed: () {
                      onboardingProvider.appStarted();
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                    },
                    customWidth: MediaQuery.of(context).size.width * 0.45,
                    customBackgroundColor: MyColor.white,
                    customTextColor: MyColor.secondaryMain,
                  ),
                  PrimaryButton(
                    teks: 'Next',
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    customWidth: MediaQuery.of(context).size.width * 0.45,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
