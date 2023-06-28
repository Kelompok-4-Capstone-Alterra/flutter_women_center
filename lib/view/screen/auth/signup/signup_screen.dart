import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/auth/signup/signup_view_model.dart';
import 'package:capstone_project/view/screen/auth/verification/verification_screen.dart';
import 'package:capstone_project/view/screen/auth/verification/verification_veiw_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../model/signup_model.dart';
import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/text_box/regular_text_box/text_box.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_size.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final SignupViewModel signupProvider;
  late final VerificationViewModel verificationProvider;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void clearText() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _usernameController.clear();
  }

  @override
  void initState() {
    signupProvider = Provider.of<SignupViewModel>(context, listen: false);
    verificationProvider =
        Provider.of<VerificationViewModel>(context, listen: false);
    signupProvider.addListener(
      () {
        if (signupProvider.state == MyState.loaded) {
          verificationProvider.setEmail(_emailController.text);
          Navigator.pushNamed(
            context,
            VerificationScreen.routeName,
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
        judul: 'Create Account',
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
                key: formKey,
                child: ListView(
                  children: [
                    Text(
                      'Let’s get started with us.',
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
                      'Go ahead and sign up now to take the first step towards a brighter future',
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
                      'Name',
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
                      textEditingController: _nameController,
                      hintText: "Ex : johndoe",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null ||
                            p0.isEmpty ||
                            !RegExp(r'^(?!\s+$)').hasMatch(p0)) {
                          return 'name is required';
                        }
                        if (!RegExp(r'^[^\s].*').hasMatch(p0)) {
                          return 'invalid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
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
                      hintText: "Ex : johndoe@example.com",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null ||
                            p0.isEmpty ||
                            !RegExp(r'^(?!\s+$)').hasMatch(p0)) {
                          return 'email is required';
                        } else if (!RegExp(
                          r"^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$",
                        ).hasMatch(p0)) {
                          return 'email is not valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Username',
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
                      textEditingController: _usernameController,
                      hintText: "Ex : johndoe",
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null ||
                            p0.isEmpty ||
                            !RegExp(r'^(?!\s+$)').hasMatch(p0)) {
                          return 'username is required';
                        }
                        if (!RegExp(r'^[^\s]*$').hasMatch(p0)) {
                          return 'username cannot contain spaces';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MyColor.neutralHigh,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Consumer<SignupViewModel>(
                      builder: (context, value, _) {
                        return TextBox(
                          textEditingController: _passwordController,
                          hintText: "Sstt Its a Secret",
                          keyboardType: TextInputType.text,
                          obscureText: !value.passwordVisibility,
                          obscureChar: '*',
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.setPasswordVisibility();
                            },
                            icon: Icon(
                              value.passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                            ),
                          ),
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'password is required';
                            } else if (p0.length < 8) {
                              return 'password must be at least 8 characters';
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
                      teks: 'Sign Up',
                      customChild: Consumer<SignupViewModel>(
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: MyColor.white,
                              ),
                            );
                          }
                        },
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          signupProvider.setData(
                            SignupModel(
                              name: _nameController.text,
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              otp: '',
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                        GestureDetector(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.secondaryPressed,
                              ),
                            ),
                            onTap: () => Navigator.pop(context)),
                      ],
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
      ),
    );
  }
}
