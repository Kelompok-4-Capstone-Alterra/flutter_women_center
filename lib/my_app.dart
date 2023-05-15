import 'package:capstone_project/preview_component_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Women Center',
      initialRoute: PreviewComponentPage.routeName,
      routes: {
        PreviewComponentPage.routeName: (context) =>
            const PreviewComponentPage(),
      },
    );
  }
}
