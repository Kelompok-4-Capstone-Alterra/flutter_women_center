import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/utils/components/text_box/read_only_text_box.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/profile/edit_profile/edit_profile_screen.dart';
import 'package:capstone_project/view/screen/profile/profilel_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/components/buttons/primary_button.dart';
import '../../../utils/constant_text.dart';
import '../../../utils/my_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileViewModel profileProvider;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileViewModel>(context, listen: false);
    profileProvider.reset();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileProvider.initProfile();
    });
    super.initState();
  }

  void _showAlert(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: MyColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: MyColor.neutralMediumLow, width: .5),
          ),
          title: Text(
            'Are you sure want to Sign Out from your account?',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: MyColor.neutralHigh,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            PrimaryButton(
              teks: 'Sure',
              onPressed: () {
                profileProvider.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            PrimaryButton(
              teks: 'Maybe Latter',
              onPressed: () {
                Navigator.pop(context);
              },
              customBackgroundColor: MyColor.neutralLow,
              customTextColor: MyColor.primaryMain,
            )
          ],
        );
      },
    );
  }

  void _showImage(ImageProvider<Object> imageData) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageData,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Profile',
        home: false,
        searchField: false,
        tabBar: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: MyColor.background,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MySize.screenPadding,
                  top: MediaQuery.of(context).size.height * 0.05,
                  right: MySize.screenPadding),
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Consumer<ProfileViewModel>(
                      builder: (context, value, child) {
                        if (value.state == MyState.loading) {
                          return const SizedBox();
                        } else {
                          return value.userData.picturePath == ''
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color: MyColor.primaryBorder,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: GestureDetector(
                                    child: Image.network(
                                      value.userData.picturePath ?? '',
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                    onTap: () {
                                      _showImage(
                                        NetworkImage(
                                          profileProvider
                                                  .userData.picturePath ??
                                              '',
                                        ),
                                      );
                                    },
                                  ),
                                );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Consumer<ProfileViewModel>(
                    builder: (context, value, _) {
                      if (value.state == MyState.loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColor.primaryMain,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                value.userData.username ?? '-',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: MyColor.neutralHigh,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Center(
                              child: Text(
                                value.userData.phone ?? '-',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.neutralMediumLow,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  ReadOnlyTextBox(
                    value: 'Edit Profile',
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Consumer<ProfileViewModel>(
                    builder: (context, value, _) {
                      return Column(
                        children: [
                          ReadOnlyTextBox(
                            value: 'About Us',
                            suffixIcon: IconButton(
                              onPressed: () {
                                value.setShowAboutUs();
                              },
                              icon: value.showAboutUs
                                  ? const Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 25,
                                    )
                                  : const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                    ),
                            ),
                          ),
                          if (value.showAboutUs)
                            const ReadOnlyTextBox(
                              value: about,
                            ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          ReadOnlyTextBox(
                            value: 'FAQ',
                            suffixIcon: IconButton(
                              onPressed: () {
                                value.setShowFaq();
                              },
                              icon: value.showFaq
                                  ? const Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 25,
                                    )
                                  : const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                    ),
                            ),
                          ),
                          if (value.showFaq)
                            const ReadOnlyTextBox(
                              value: faq,
                            ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          ReadOnlyTextBox(
                            value: 'Term & Conditions',
                            suffixIcon: IconButton(
                              onPressed: () {
                                value.setShowTermAndConditions();
                              },
                              icon: value.showTermAndConditions
                                  ? const Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 25,
                                    )
                                  : const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 25,
                                    ),
                            ),
                          ),
                          if (value.showTermAndConditions)
                            const ReadOnlyTextBox(
                              value: termAndConditions,
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  PrimaryButton(
                    teks: 'Sign Out',
                    onPressed: () {
                      _showAlert(context);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
