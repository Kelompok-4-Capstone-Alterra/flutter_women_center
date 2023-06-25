import 'dart:io';

import 'package:capstone_project/utils/key/naviagtor_key.dart';
import 'package:capstone_project/view/screen/article/article_detail/article_detail_view_model.dart';
import 'package:capstone_project/view/screen/article/article_detail/comment/comment_view_model.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_post/article_list_post_view_model.dart';
import 'package:capstone_project/view/screen/article/save_content/save_content_view_model.dart';
import 'package:capstone_project/view/screen/counseling_appointment/counseling_appointment_screen.dart';
import 'package:capstone_project/view/screen/counseling_appointment/counseling_appointment_view_model.dart';
import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/counselor_detail/counselor_detail_view_model.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_screen.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_view_model.dart';

import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar_view_model.dart';
import 'package:capstone_project/view/screen/article/article_detail/article_detail_screen.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_screen.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_view_model.dart';
import 'package:capstone_project/view/screen/forum/forum_discussion_screen.dart';
import 'package:capstone_project/view/screen/forum/forum_discussion_view_model.dart';
import 'package:capstone_project/view/screen/forum/widget/option_sord_by_view_model.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/home/home_view_model.dart';
import 'package:capstone_project/view/screen/home/search/search_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_view_model.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:capstone_project/view/screen/auth/forgot_password/forgot_password_view_model.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/auth/login/login_view_model.dart';
import 'package:capstone_project/view/screen/onboarding/onboarding_screen.dart';
import 'package:capstone_project/view/screen/onboarding/onboarding_view_model.dart';
import 'package:capstone_project/view/screen/profile/change_password/change_password_screen.dart';
import 'package:capstone_project/view/screen/profile/change_password/change_password_view_model.dart';
import 'package:capstone_project/view/screen/profile/edit_profile/edit_profile_screen.dart';
import 'package:capstone_project/view/screen/profile/edit_profile/edit_profile_view_model.dart';
import 'package:capstone_project/view/screen/profile/profile_screen.dart';
import 'package:capstone_project/view/screen/profile/profilel_view_model.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_screen.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:capstone_project/view/screen/saved/search/search_saved_screen.dart';
import 'package:capstone_project/view/screen/saved/search/search_saved_view_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_search/search_transactions_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_search/search_transactions_view_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_view_model.dart';
import 'package:capstone_project/view/screen/voucher/voucher_screen.dart';
import 'package:capstone_project/view/screen/voucher/voucher_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:capstone_project/view/screen/auth/signup/signup_screen.dart';
import 'package:capstone_project/view/screen/auth/signup/signup_view_model.dart';
import 'package:capstone_project/view/screen/auth/verification/verification_screen.dart';
import 'package:capstone_project/view/screen/auth/verification/verification_veiw_model.dart';
import 'package:capstone_project/view/screen/auth/verification/widgets/otp_form_view_model.dart';
import 'package:provider/provider.dart';
import 'view/screen/career/career_detail/career_detail_screen.dart';
import 'view/screen/career/career_detail/career_detail_view_model.dart';
import 'view/screen/career/career_list/career_list_screen.dart';
import 'view/screen/career/career_list/career_list_view_model.dart';
import 'view/screen/counseling_topic/counseling_topic_view_model.dart';
import 'view/screen/counselor_detail/counselor_detail_screen.dart';

void main() {
  HttpOverrides.global = PostHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
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
          create: (context) => CounselingTopicViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselorListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselorDetailViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleListProvider(),
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
        ChangeNotifierProvider(
          create: (context) => OnboardingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselingAppointmentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => VoucherViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselingAppointmentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => VoucherViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangePasswordViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => OptionSortByViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavBarViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CareerListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailCareerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchSavedViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchTransactionsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForumDiscussionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleListPostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaveContentProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woman Center',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: LandingScreen.routeName,
        navigatorKey: navigatorKey,
        routes: {
          LandingScreen.routeName: (context) => const LandingScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          TransactionScreen.routeName: (context) => const TransactionScreen(),
          SavedScreen.routeName: (context) => const SavedScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          ArticleListScreen.routename: (context) => const ArticleListScreen(),
          DetailReadingListScreen.routeName: (context) =>
              const DetailReadingListScreen(),
          CounselingTopicScreen.routeName: (context) =>
              const CounselingTopicScreen(),
          CounselorListScreen.routeName: (context) =>
              const CounselorListScreen(),
          CounselorDetailScreen.routeName: (context) =>
              const CounselorDetailScreen(
                id: 0,
              ),
          ArticleDetailsScreen.routename: (context) =>
              const ArticleDetailsScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          VerificationScreen.routeName: (context) => const VerificationScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),
          OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          EditProfileScreen.routeName: (context) => const EditProfileScreen(),
          ChangePasswordScreen.routeName: (context) =>
              const ChangePasswordScreen(),
          CounselingAppointment.routeName: (context) =>
              const CounselingAppointment(),
          VoucherScreen.routeName: (context) => const VoucherScreen(),
          CareerListScreen.routeName: (context) => const CareerListScreen(),
          CareerDetailScreen.routeName: (context) => const CareerDetailScreen(
                id: '',
              ),
          SearchSavedScreen.routeName: (context) => const SearchSavedScreen(),
          SearchTransactionsScreen.routeName: (context) =>
              const SearchTransactionsScreen(),
          ForumDiscussionScreen.routeName: (context) =>
              const ForumDiscussionScreen(),
        },
      ),
    );
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
