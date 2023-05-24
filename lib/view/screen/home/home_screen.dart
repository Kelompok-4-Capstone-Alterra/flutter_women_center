import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
          judul: 'Home',
          home: true,
          searchField: true,
          tabBar: false,
        ),
        body: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          child: Text('login'),
        ));
  }
}
