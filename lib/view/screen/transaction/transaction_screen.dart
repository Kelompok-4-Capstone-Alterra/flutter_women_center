import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/view/screen/transaction/transaction_view_model.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/transaction/widgets/transaction_bottom_sheet_builder.dart';
import 'package:capstone_project/view/screen/transaction/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  static const String routeName = '/transaction_screen';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _counselingCounselorController =
      TextEditingController();
  final FocusNode _counselingCounselorNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionViewModel>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          preferredSize: Size(
            MySize.screenWidth(context),
            double.maxFinite,
          ),
          judul: 'Transaction',
          home: false,
          searchField: true,
          tabBar: true,
          tabs: const [
            Tab(
              text: 'Ongoing',
            ),
            Tab(
              text: 'History',
            ),
          ],
          searchTextBox:
              SearchTextBox(textEditingController: _searchController),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 1,
          onTap: (index) {},
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              ListView.separated(
                itemBuilder: (context, index) {
                  return TransactionCard(
                    ratingDone: false,
                    labelButton: 'Link',
                    onPressed: () {},
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: 5,
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const TransactionCard(
                      ratingDone: true,
                      labelButton: 'Rate & Review',
                    );
                  }
                  return TransactionCard(
                    ratingDone: false,
                    labelButton: 'Rate & Review',
                    onPressed: () {
                      showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          for (int i = 0;
                              i < provider.counselingSessionRate.length;
                              i++) {
                            provider.counselingSessionRate[i] = false;
                          }
                          for (int i = 0;
                              i < provider.counselorRate.length;
                              i++) {
                            provider.counselorRate[i] = false;
                          }
                          provider.counselingSessionTotalRate = 0;
                          provider.counselorTotalRate = 0;
                          return TransactionBottomSheet(
                            judul: 'Give Rate & Review',
                            isi: [
                              SizedBox(
                                height: 103,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'How was your counseling session?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor.neutralHigh,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: provider
                                              .counselingSessionRate.length,
                                          itemBuilder: (context, index) {
                                            return Consumer<
                                                TransactionViewModel>(
                                              builder: (context,
                                                  transactionProvider, _) {
                                                if (transactionProvider
                                                            .counselingSessionRate[
                                                        index] ==
                                                    true) {
                                                  return IconButton(
                                                    onPressed: () {
                                                      transactionProvider
                                                          .changeCounselingSessionRate(
                                                              index: index);
                                                    },
                                                    icon: Icon(
                                                      Icons.star,
                                                      size: 32,
                                                      color: MyColor.warning,
                                                    ),
                                                  );
                                                } else {
                                                  return IconButton(
                                                    onPressed: () {
                                                      transactionProvider
                                                          .changeCounselingSessionRate(
                                                              index: index);
                                                    },
                                                    icon: Icon(
                                                      Icons.star,
                                                      size: 32,
                                                      color: MyColor.neutralLow,
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Text(
                                        'Please give us the rating',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.danger,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 86,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'How was your counselor?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor.neutralHigh,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250,
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              provider.counselorRate.length,
                                          itemBuilder: (context, index) {
                                            return Consumer<
                                                TransactionViewModel>(
                                              builder: (context,
                                                  transactionProvider, _) {
                                                if (transactionProvider
                                                        .counselorRate[index] ==
                                                    true) {
                                                  return IconButton(
                                                    onPressed: () {
                                                      transactionProvider
                                                          .changeCounselorRate(
                                                              index: index);
                                                    },
                                                    icon: Icon(
                                                      Icons.star,
                                                      size: 32,
                                                      color: MyColor.warning,
                                                    ),
                                                  );
                                                } else {
                                                  return IconButton(
                                                    onPressed: () {
                                                      transactionProvider
                                                          .changeCounselorRate(
                                                              index: index);
                                                    },
                                                    icon: Icon(
                                                      Icons.star,
                                                      size: 32,
                                                      color: MyColor.neutralLow,
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 86,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Any words about your counseling or counselor?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColor.neutralHigh,
                                        ),
                                      ),
                                      TextBox(
                                        textEditingController:
                                            _counselingCounselorController,
                                        hintText:
                                            'Type what you are thinking here ...',
                                        last: true,
                                        currentFocus: _counselingCounselorNode,
                                        validator: null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PrimaryButton(
                                teks: 'Done',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
