import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/login/login_screen.dart';
import 'package:capstone_project/view/screen/signup/verification/verification_veiw_model.dart';
import 'package:capstone_project/view/screen/signup/verification/widgets/otp_box.dart';
import 'package:capstone_project/view/screen/signup/verification/widgets/otp_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/components/buttons/primary_button.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<OtpFormViewModel>(context, listen: false).startTimer();
    super.initState();
  }

  // function to show alert dialog
  void _showAlertSuccess(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: MyColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: MyColor.neutralLow, width: .5),
          ),
          title: Icon(Icons.check_circle, color: MyColor.success, size: 50),
          content: Text(
            'Verification Completed!',
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

  void _showAlertError(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 90),
          surfaceTintColor: MyColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(color: MyColor.neutralLow, width: .5),
          ),
          title: Icon(Icons.sms_failed, color: MyColor.danger, size: 50),
          content: Text(
            'Verification Failed! Please fill in the input box with the correct code.',
            textAlign: TextAlign.center,
            style: TextStyle(color: MyColor.neutralHigh, fontSize: 12),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final verificationProvider =
        Provider.of<VerificationViewModel>(context, listen: false);
    final otpFormProvider =
        Provider.of<OtpFormViewModel>(context, listen: false);
    return Form(
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
                    FocusScope.of(context).nextFocus();
                    verificationProvider.setPin(value, 1);
                  },
                ),
                OtpBox(
                  onChanged: (value) {
                    FocusScope.of(context).nextFocus();
                    verificationProvider.setPin(value, 2);
                  },
                ),
                OtpBox(
                  onChanged: (value) {
                    FocusScope.of(context).nextFocus();
                    verificationProvider.setPin(value, 3);
                  },
                ),
                OtpBox(
                  onChanged: (value) {
                    FocusScope.of(context).nextFocus();
                    verificationProvider.setPin(value, 4);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Consumer<OtpFormViewModel>(
            builder: (context, value, _) {
              String twoDigits(int n) => n.toString().padLeft(2, '0');
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
                'Don’t receive the code? ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.neutralMediumLow,
                ),
              ),
              Consumer<OtpFormViewModel>(
                builder: (context, value, _) {
                  return GestureDetector(
                    onTap: () {
                      if (value.duration.inSeconds == 0) {
                        verificationProvider.resendCode();
                        otpFormProvider.resetTimer();
                      }
                      print('durasi belum habis');
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                verificationProvider.verify();
                verificationProvider.state == MyState.failed
                    ? _showAlertError(context)
                    : _showAlertSuccess(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
