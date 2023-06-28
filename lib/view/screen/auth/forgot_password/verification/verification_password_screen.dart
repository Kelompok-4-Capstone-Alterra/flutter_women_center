import 'dart:async';

import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_view_model.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/verification/verification_password_veiw_model.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/auth/verification/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../../utils/components/buttons/primary_button.dart';
import '../../../../../utils/my_color.dart';
import '../../../../../utils/my_size.dart';

class VerificationPasswordScreen extends StatefulWidget {
  const VerificationPasswordScreen({super.key});

  static const String routeName = '/verification_password_screen';

  @override
  State<VerificationPasswordScreen> createState() =>
      _VerificationPasswordScreenState();
}

class _VerificationPasswordScreenState
    extends State<VerificationPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ForgotPasswordViewModel forgotPasswordProvider;
  late final VerificationPasswordViewModel verificationProvider;

  @override
  void initState() {
    super.initState();
    forgotPasswordProvider =
        Provider.of<ForgotPasswordViewModel>(context, listen: false);
    verificationProvider =
        Provider.of<VerificationPasswordViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        verificationProvider.resetTimer();
        forgotPasswordProvider.changeState(MyState.initial);
      },
    );
    forgotPasswordProvider.addListener(
      () {
        if (forgotPasswordProvider.state == MyState.loaded) {
          verificationProvider.stopTimer();
          _showAlertSuccess(context);
        }
      },
    );
  }

  void _showAlertSuccess(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context).pop(),
        );
        return AlertDialog(
          surfaceTintColor: MyColor.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: MyColor.neutralLow, width: .5),
          ),
          title: Icon(Icons.check_circle, color: MyColor.success, size: 50),
          content: Text(
            'Verification Completed! Please check your email to get your temporary password.',
            textAlign: TextAlign.center,
            style: TextStyle(color: MyColor.neutralHigh, fontSize: 12),
          ),
        );
      },
    ).then(
      (value) => Navigator.of(context).popUntil(
        (route) {
          return route.settings.name == LoginScreen.routeName;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Reset Password',
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
                  Text(
                    "Let's get your new password.",
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
                    'Verification code has been sent to your email',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMediumLow,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Please check your inbox and type the 4-digit unique code that has just been sent to verify your email and complete the reset password process.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMediumLow,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OtpBox(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                    verificationProvider.setPin(value, 1);
                                  }
                                },
                              ),
                              OtpBox(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                    verificationProvider.setPin(value, 2);
                                  }
                                },
                              ),
                              OtpBox(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                    verificationProvider.setPin(value, 3);
                                  }
                                },
                              ),
                              OtpBox(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                    verificationProvider.setPin(value, 4);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Consumer<VerificationPasswordViewModel>(
                          builder: (context, value, _) {
                            String twoDigits(int n) =>
                                n.toString().padLeft(2, '0');
                            final minutes = value.duration.inMinutes;
                            final seconds = value.duration.inSeconds % 60;

                            return Text(
                              '${twoDigits(minutes)}:${twoDigits(seconds)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: MyColor.primaryMain,
                              ),
                            );
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              "Don't receive the code? ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMediumLow,
                              ),
                            ),
                            Consumer<VerificationPasswordViewModel>(
                              builder: (context, value, _) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (value.duration.inSeconds == 0) {
                                      await verificationProvider.requestOtp();
                                      verificationProvider.resetTimer();
                                    }
                                  },
                                  child: Text(
                                    'Request new code',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.secondaryPressed,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        PrimaryButton(
                          teks: 'Verify Now',
                          customChild: Consumer<ForgotPasswordViewModel>(
                            builder: (context, value, _) {
                              return value.state == MyState.loading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: MyColor.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Verify Now',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: MyColor.white,
                                      ),
                                    );
                            },
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              forgotPasswordProvider
                                  .requestNewPassword(verificationProvider.otp);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
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
