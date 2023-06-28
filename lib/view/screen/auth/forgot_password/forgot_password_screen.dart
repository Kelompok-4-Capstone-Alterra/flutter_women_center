import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_view_model.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/verification/verification_password_screen.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/verification/verification_password_veiw_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_size.dart';
import '../../../../utils/components/text_box/regular_text_box/text_box.dart';
import '../../../../utils/state/finite_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const routeName = '/forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ForgotPasswordViewModel forgotPasswordProvider;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    forgotPasswordProvider =
        Provider.of<ForgotPasswordViewModel>(context, listen: false);
    forgotPasswordProvider.addListener(
      () {
        if (forgotPasswordProvider.state == MyState.loaded) {
          Provider.of<VerificationPasswordViewModel>(context, listen: false)
              .setEmail(_emailController.text);
          Navigator.pushNamed(
            context,
            VerificationPasswordScreen.routeName,
          );
        }
      },
    );
    super.initState();
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
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Get your new password.',
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
                      'Please enter your email address. You’ll receive an message with instructions on how to reset your password.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralMediumLow,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextBox(
                      textEditingController: _emailController,
                      hintText: " Ex : johndoe@example.com",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'email tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    PrimaryButton(
                      teks: 'Continue',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          forgotPasswordProvider.reuestOtp(
                            _emailController.text,
                          );
                        }
                      },
                      customChild: Consumer<ForgotPasswordViewModel>(
                        builder: (context, value, _) {
                          if (value.state == MyState.loading) {
                            return SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: MyColor.white,
                                strokeWidth: 2,
                              ),
                            );
                          } else {
                            return Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: MyColor.white,
                              ),
                            );
                          }
                        },
                      ),
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
