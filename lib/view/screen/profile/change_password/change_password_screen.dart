import 'package:capstone_project/view/screen/profile/change_password/change_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_size.dart';
import '../../../../utils/components/text_box/regular_text_box/text_box.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String routeName = '/change_password_screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
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
            'Are you sure want to make a change?',
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
                Navigator.pop(context);
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
    ).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Edit Profile',
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
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Change your password here.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralMediumLow,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      'Current Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Consumer<ChangePasswordViewModel>(
                      builder: (context, value, _) {
                        return TextBox(
                          textEditingController: _currentPasswordController,
                          hintText: "Sstt Its a Secret",
                          keyboardType: TextInputType.text,
                          obscureText: !value.currentPasswordVisibility,
                          obscureChar: '*',
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.setCurrentPasswordVisibility();
                            },
                            icon: Icon(
                              value.currentPasswordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                            ),
                          ),
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'password tidak boleh kosong';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'New Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Consumer<ChangePasswordViewModel>(
                      builder: (context, value, _) {
                        return TextBox(
                          textEditingController: _newPasswordController,
                          hintText: "Sstt Its a Secret",
                          keyboardType: TextInputType.text,
                          obscureText: !value.newPasswordVisibility,
                          obscureChar: '*',
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.setNewPasswordVisibility();
                            },
                            icon: Icon(
                              value.newPasswordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                            ),
                          ),
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'password tidak boleh kosong';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    PrimaryButton(
                      teks: 'Save Changes',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showAlert(context);
                        }
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
      ),
    );
  }
}
