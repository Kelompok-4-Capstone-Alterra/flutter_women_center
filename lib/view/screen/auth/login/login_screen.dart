import 'package:capstone_project/model/login_model.dart';
import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:capstone_project/view/screen/auth/login/login_view_model.dart';
import 'package:capstone_project/view/screen/auth/signup/signup_screen.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/my_size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LogniScreenState();
}

class _LogniScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final LoginViewModel loginProvider;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loginProvider = Provider.of<LoginViewModel>(context, listen: false);
    loginProvider.init();
    loginProvider.addListener(
      () {
        if (loginProvider.state == MyState.loaded) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginViewModel>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Log In',
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
                      'Hello ! Welcome back.',
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
                      'Please sign in to get full access to our services and resources',
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
                    Consumer<LoginViewModel>(
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
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgotPasswordScreen.routeName);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.secondaryPressed,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    PrimaryButton(
                      teks: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginProvider.login(
                            LoginModel(
                                username: _usernameController.text,
                                password: _passwordController.text),
                          );
                        }
                      },
                      customChild: Consumer<LoginViewModel>(
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
                              'Login',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColor.secondaryPressed,
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, SignupScreen.routeName),
                        ),
                      ],
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
