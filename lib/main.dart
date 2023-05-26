import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_view_model.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_view_model.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/auth/login/login_view_model.dart';
import 'package:capstone_project/view/screen/profile/profile_screen.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_screen.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_view_model.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_screen.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:capstone_project/view/screen/auth/signup/signup_screen.dart';
import 'package:capstone_project/view/screen/auth/signup/signup_view_model.dart';
import 'package:capstone_project/view/screen/auth/verification/verification_screen.dart';
import 'package:capstone_project/view/screen/auth/verification/verification_veiw_model.dart';
import 'package:capstone_project/view/screen/auth/verification/widgets/otp_form_view_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LandingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavedViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailReadingListViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerificationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtpFormViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woman Center',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: HomeScreen.routeName,
        routes: {
          LandingScreen.routeName: (context) => const LandingScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          TransactionScreen.routeName: (context) => const TransactionScreen(),
          SavedScreen.routeName: (context) => const SavedScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          DetailReadingListScreen.routeName: (context) =>
              const DetailReadingListScreen(),
          ArticleScreen.routeName: (context) => const ArticleScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          VerificationScreen.routeName: (context) => const VerificationScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),
        },
      ),
    );
  }
}
