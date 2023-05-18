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
          create: (context) => TransactionViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woman Center',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: TransactionScreen.routeName,
        routes: {
          TransactionScreen.routeName: (context) => const TransactionScreen(),
        },
      ),
    );
  }
}
