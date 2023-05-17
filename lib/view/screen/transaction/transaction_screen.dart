import 'package:capstone_project/utils/components/buttons/primary_button_icon.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  static const String routeName = '/transaction_screen';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 239),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 42,
              ),
              AppBar(
                toolbarHeight: 40,
                title: Text(
                  'Transaction',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MyColor.info,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PrimaryButtonIcon(
                      teks: 'Add List',
                      widget: Icon(
                        Icons.add,
                        color: MyColor.white,
                      ),
                      onPressed: () {},
                      customHeight: 36,
                      customWidth: 119,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SearchTextBox(textEditingController: _searchController),
              const SizedBox(
                height: 32,
              ),
              Divider(
                height: 1,
                color: MyColor.subInfo,
                thickness: .5,
              ),
              SizedBox(
                height: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    indicatorWeight: 1,
                    indicatorColor: MyColor.primary,
                    labelColor: MyColor.primary,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: MyColor.info,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(
                        text: 'Ongoing',
                      ),
                      Tab(
                        text: 'History',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // TransactionAppbar(
              //   textEditingController: _searchController,
              //   title: 'Transaction',
              // ),

              // TabBar(
              //   indicatorColor: MyColor.primary,
              //   labelColor: MyColor.primary,
              //   labelStyle: const TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //   ),
              //   unselectedLabelColor: MyColor.info,
              //   unselectedLabelStyle: const TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //   ),
              //   tabs: const [
              //     Tab(
              //       text: 'Ongoing',
              //     ),
              //     Tab(
              //       text: 'History',
              //     ),
              //   ],
              // ),
              // const TabBarView(
              //   children: [
              //     Expanded(child: Text('teks')),
              //     Expanded(child: Text('teks')),
              //     Expanded(child: Text('teks')),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
