import 'package:capstone_project/view/screen/auth/verification/verification_veiw_model.dart';
import 'package:capstone_project/view/screen/auth/verification/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_size.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  static const String routeName = '/verification_screen';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Verify Email',
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
                    'Let’s verify your email.',
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
                  const OtpForm(),
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
