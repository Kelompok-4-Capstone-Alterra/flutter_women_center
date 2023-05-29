import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/text_box/read_only_text_box.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/onboarding/onboarding_screen.dart';
import 'package:capstone_project/view/screen/profile/edit_profile/edit_profile_screen.dart';
import 'package:capstone_project/view/screen/profile/profilel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/components/buttons/primary_button.dart';
import '../../../utils/my_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileViewModel>(context, listen: false).reset();
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, OnboardingScreen.routeName, (route) => false);
                }),
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
                    radius: 32,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: MyColor.primaryBorder,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                    child: Text(
                      'John Doe',
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
                      '+6281732613713',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralMediumLow,
                      ),
                    ),
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
                              value:
                                  "Our women's center is dedicated to promoting gender equity and supporting the health, well-being, and empowerment of women. We provide a safe and inclusive space for women to access resources, connect with other women, and become agents of positive change in their lives and communities.",
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
                              value:
                                  "Our women's center is dedicated to promoting gender equity and supporting the health, well-being, and empowerment of women. We provide a safe and inclusive space for women to access resources, connect with other women, and become agents of positive change in their lives and communities.",
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
                              value:
                                  "Our women's center is dedicated to promoting gender equity and supporting the health, well-being, and empowerment of women. We provide a safe and inclusive space for women to access resources, connect with other women, and become agents of positive change in their lives and communities.",
                            ),
                        ],
                      );
                    },
                  ),

                  // TextBox(
                  //   textEditingController: _usernameController,
                  //   hintText: "Ex : johndoe",
                  //   keyboardType: TextInputType.text,
                  //   validator: (p0) {
                  //     if (p0 == null || p0.isEmpty) {
                  //       return 'username tidak boleh kosong';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // Consumer<LoginViewModel>(
                  //   builder: (context, value, _) {
                  //     return TextBox(
                  //       textEditingController: _passwordController,
                  //       hintText: "Sstt Its a Secret",
                  //       keyboardType: TextInputType.text,
                  //       obscureText: !value.passwordVisibility,
                  //       obscureChar: '*',
                  //       suffixIcon: IconButton(
                  //         onPressed: () {
                  //           value.setPasswordVisibility();
                  //         },
                  //         icon: Icon(
                  //           value.passwordVisibility
                  //               ? Icons.visibility
                  //               : Icons.visibility_off,
                  //           size: 22,
                  //         ),
                  //       ),
                  //       validator: (p0) {
                  //         if (p0 == null || p0.isEmpty) {
                  //           return 'password tidak boleh kosong';
                  //         }
                  //         return null;
                  //       },
                  //     );
                  //   },
                  // ),

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //         context, ForgotPasswordScreen.routeName);
                  //   },
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Text(
                  //       'Change Password',
                  //       style: TextStyle(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w400,
                  //         color: MyColor.secondaryPressed,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
    );
  }
}
