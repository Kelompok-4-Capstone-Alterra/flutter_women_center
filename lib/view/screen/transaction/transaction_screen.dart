import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/formarter/date_formater.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/components/loading/loading.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/transaction/transaction_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/transaction/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final MoneyFormatter _moneyFormatter = MoneyFormatter();

  late final TransactionViewModel provider;

  @override
  void initState() {
    provider = Provider.of<TransactionViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.showAllTransactionsOngoing();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _counselingCounselorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              //tab ongoing
              RefreshIndicator(
                strokeWidth: 2,
                color: MyColor.primaryMain,
                onRefresh: () {
                  return provider.showAllTransactionsOngoing();
                },
                child: Consumer<TransactionViewModel>(
                    builder: (context, transactionProvider, _) {
                  if (transactionProvider.state == MyState.loading) {
                    return const Loading();
                  } else {
                    if (transactionProvider
                        .allTransactionsOngoingData.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/nothing_here.png'),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Woops! Sorry, no result found.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: MyColor.neutralHigh,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: transactionProvider
                            .allTransactionsOngoingData.length,
                        itemBuilder: (context, index) {
                          late String timeStart;
                          late String price;
                          if (transactionProvider
                                  .allTransactionsOngoingData[index]
                                  .counselorData ==
                              null) {
                            return TransactionCard(
                              showButton: true,
                              labelButton: 'Link',
                              linkImage: '-',
                              counselorId: '-',
                              counselorName: '-',
                              topic: '-',
                              method: '-',
                              timeStart: '-',
                              price: 'Rp. 0',
                              onPressed: () async {
                                final Uri _url = Uri.parse(transactionProvider
                                            .allTransactionsOngoingData[index]
                                            .link ==
                                        null
                                    ? ''
                                    : transactionProvider
                                        .allTransactionsOngoingData[index]
                                        .link!);
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                              },
                            );
                          } else {
                            timeStart = DateFormatter.format(transactionProvider
                                .allTransactionsOngoingData[index].timeStart!);
                            if (transactionProvider
                                    .allTransactionsOngoingData[index]
                                    .counselorData!
                                    .price ==
                                null) {
                              price = _moneyFormatter.formatRupiah(0);
                            } else {
                              price = _moneyFormatter.formatRupiah(
                                  transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .counselorData!
                                      .price!);
                            }
                            return TransactionCard(
                              showButton: true,
                              labelButton: 'Link',
                              onPressed: () async {
                                final Uri _url = Uri.parse(transactionProvider
                                            .allTransactionsOngoingData[index]
                                            .link ==
                                        null
                                    ? ''
                                    : transactionProvider
                                        .allTransactionsOngoingData[index]
                                        .link!);
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                              },
                              linkImage: transactionProvider
                                          .allTransactionsOngoingData[index]
                                          .counselorData!
                                          .profilePicture ==
                                      null
                                  ? '-'
                                  : transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .counselorData!
                                      .profilePicture!,
                              counselorId: transactionProvider
                                          .allTransactionsOngoingData[index]
                                          .counselorData!
                                          .id ==
                                      null
                                  ? '-'
                                  : transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .counselorData!
                                      .id!,
                              counselorName: transactionProvider
                                          .allTransactionsOngoingData[index]
                                          .counselorData!
                                          .name ==
                                      null
                                  ? '-'
                                  : transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .counselorData!
                                      .name!,
                              method: transactionProvider
                                          .allTransactionsOngoingData[index]
                                          .consultationMethod ==
                                      null
                                  ? '-'
                                  : transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .consultationMethod!,
                              price: price,
                              timeStart: transactionProvider
                                          .allTransactionsOngoingData[index]
                                          .timeStart ==
                                      null
                                  ? '-'
                                  : transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .timeStart!,
                              topic: transactionProvider
                                          .allTransactionsOngoingData[index]
                                          .counselorData!
                                          .topic ==
                                      null
                                  ? '-'
                                  : transactionProvider
                                      .allTransactionsOngoingData[index]
                                      .counselorData!
                                      .topic!,
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                      );
                    }
                  }
                }),
              ),
              //tab history
              ListView.separated(
                itemBuilder: (context, index) {
                  return Consumer<TransactionViewModel>(
                      builder: (context, transactionProvider, _) {
                    return TransactionCard(
                      showButton: transactionProvider.history[index] == true
                          ? false
                          : true,
                      labelButton: 'Rate & Review',
                      onPressed: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            for (int i = 0;
                                i < provider.counselorRate.length;
                                i++) {
                              provider.counselorRate[i] = false;
                            }
                            provider.counselorTotalRate = 0;
                            return CustomBottomSheetBuilder(
                              tinggi: 680,
                              header: true,
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
                                          MainAxisAlignment.start,
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
                                                              .counselorRate[
                                                          index] ==
                                                      true) {
                                                    return IconButton(
                                                      onPressed: () {
                                                        transactionProvider
                                                            .changeCounselorRate(
                                                                index);
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
                                                                index);
                                                      },
                                                      icon: Icon(
                                                        Icons.star,
                                                        size: 32,
                                                        color:
                                                            MyColor.neutralLow,
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Consumer<TransactionViewModel>(builder:
                                            (context, transactionProvider2, _) {
                                          if (transactionProvider2
                                                  .counselorRate[0] ==
                                              true) {
                                            return const SizedBox();
                                          }
                                          return Text(
                                            'Please give us the rating',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: MyColor.danger,
                                            ),
                                          );
                                        }),
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
                                          currentFocus:
                                              _counselingCounselorNode,
                                          validator: null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Consumer<TransactionViewModel>(
                                    builder: (context, transactionProvider, _) {
                                  return PrimaryButton(
                                    teks: 'Done',
                                    onPressed:
                                        transactionProvider.counselorRate[0] ==
                                                false
                                            ? null
                                            : () {
                                                Navigator.pop(context);
                                                _counselingCounselorController
                                                    .clear();
                                                transactionProvider
                                                    .changeRatingStatus(index);
                                              },
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      },
                      linkImage: '',
                      counselorId: '123456',
                      counselorName: 'John Doe',
                      method: 'Video Call',
                      price: '125000',
                      timeStart: '12.00',
                      topic: 'Self Development',
                    );
                  });
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: provider.history.length,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
