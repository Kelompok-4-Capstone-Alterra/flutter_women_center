import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/formarter/date_formater.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/components/loading/loading.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/transaction/transaction_search/search_transactions_screen.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String tanggal;
  late String harga;

  late final TransactionViewModel provider;

  @override
  void initState() {
    provider = Provider.of<TransactionViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.showAllTransactions(statusOngoing: true);
      provider.showAllTransactions(statusOngoing: false);
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
          searchTextBox: SearchTextBox(
            textEditingController: _searchController,
            readOnly: true,
            onTap: () {
              Navigator.pushNamed(
                context,
                SearchTransactionsScreen.routeName,
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              //ongoing
              RefreshIndicator(
                strokeWidth: 2,
                color: MyColor.primaryMain,
                onRefresh: () {
                  return provider.showAllTransactions(statusOngoing: true);
                },
                child: Consumer<TransactionViewModel>(
                    builder: (context, transactionsProvider, _) {
                  if (transactionsProvider.state == MyState.loading) {
                    return const Loading();
                  } else {
                    if (transactionsProvider.allTransactionsData.isEmpty) {
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
                        itemBuilder: (context, index) {
                          //tanggal
                          if (transactionsProvider
                                  .allTransactionsData[index].createdAt ==
                              null) {
                            tanggal = '-';
                          } else {
                            tanggal = DateFormatter.format(transactionsProvider
                                .allTransactionsData[index].createdAt!);
                          }
                          //mata uang
                          if (transactionsProvider
                                  .allTransactionsData[index].totalPrice ==
                              null) {
                            harga = '-';
                          } else {
                            harga = _moneyFormatter.formatRupiah(
                                transactionsProvider
                                    .allTransactionsData[index].totalPrice!);
                          }
                          //show transaction card
                          if (transactionsProvider
                                  .allTransactionsData[index].counselorData ==
                              null) {
                            return TransactionCard(
                              showButton: true,
                              labelButton: 'Link',
                              profilePicture: '-',
                              id: transactionsProvider
                                          .allTransactionsData[index].id ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index].id!,
                              name: '-',
                              topic: '-',
                              consultationMethod: transactionsProvider
                                          .allTransactionsData[index]
                                          .consultationMethod ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index]
                                      .consultationMethod!,
                              date: tanggal,
                              time: transactionsProvider
                                          .allTransactionsData[index]
                                          .timeStart ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index].timeStart!,
                              price: harga,
                              onPressed: null,
                            );
                          } else {
                            return TransactionCard(
                              showButton: true,
                              labelButton: 'Link',
                              profilePicture: transactionsProvider
                                          .allTransactionsData[index]
                                          .counselorData!
                                          .profilePicture ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index]
                                      .counselorData!
                                      .profilePicture!,
                              id: transactionsProvider
                                          .allTransactionsData[index].id ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index].id!,
                              name: transactionsProvider
                                          .allTransactionsData[index]
                                          .counselorData!
                                          .name ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index]
                                      .counselorData!
                                      .name!,
                              topic: transactionsProvider
                                          .allTransactionsData[index]
                                          .counselorData!
                                          .topic ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index]
                                      .counselorData!
                                      .topic!,
                              consultationMethod: transactionsProvider
                                          .allTransactionsData[index]
                                          .consultationMethod ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index]
                                      .consultationMethod!,
                              date: tanggal,
                              time: transactionsProvider
                                          .allTransactionsData[index]
                                          .timeStart ==
                                      null
                                  ? '-'
                                  : transactionsProvider
                                      .allTransactionsData[index].timeStart!,
                              price: harga,
                              onPressed: () async {
                                final Uri _url = Uri.parse(transactionsProvider
                                            .allTransactionsData[index].link ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index].link!);
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                              },
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount:
                            transactionsProvider.allTransactionsData.length,
                      );
                    }
                  }
                  ;
                }),
              ),
              //history
              RefreshIndicator(
                strokeWidth: 2,
                color: MyColor.primaryMain,
                onRefresh: () {
                  return provider.showAllTransactions(statusOngoing: false);
                },
                child: Consumer<TransactionViewModel>(
                    builder: (context, transactionsProvider, _) {
                  if (transactionsProvider.state == MyState.loading) {
                    return const Loading();
                  } else {
                    if (transactionsProvider.allTransactionsData.isEmpty) {
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
                        itemBuilder: (context, index) {
                          return Consumer<TransactionViewModel>(
                              builder: (context, transactionProvider, _) {
                            //tanggal
                            if (transactionsProvider
                                    .allTransactionsData[index].createdAt ==
                                null) {
                              tanggal = '-';
                            } else {
                              tanggal = DateFormatter.format(
                                  transactionsProvider
                                      .allTransactionsData[index].createdAt!);
                            }
                            //mata uang
                            if (transactionsProvider
                                    .allTransactionsData[index].totalPrice ==
                                null) {
                              harga = '-';
                            } else {
                              harga = _moneyFormatter.formatRupiah(
                                  transactionsProvider
                                      .allTransactionsData[index].totalPrice!);
                            }
                            //show transaction card
                            if (transactionsProvider
                                    .allTransactionsData[index].counselorData ==
                                null) {
                              return TransactionCard(
                                showButton: true,
                                labelButton: 'Rate & Review',
                                profilePicture: '-',
                                id: transactionsProvider
                                            .allTransactionsData[index].id ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index].id!,
                                name: '-',
                                topic: '-',
                                consultationMethod: transactionsProvider
                                            .allTransactionsData[index]
                                            .consultationMethod ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index]
                                        .consultationMethod!,
                                date: tanggal,
                                time: transactionsProvider
                                            .allTransactionsData[index]
                                            .timeStart ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index].timeStart!,
                                price: harga,
                                onPressed: null,
                              );
                            } else {
                              return TransactionCard(
                                showButton: transactionProvider
                                            .allTransactionsData[index]
                                            .isReviewed ==
                                        false
                                    ? true
                                    : false,
                                labelButton: 'Rate & Review',
                                profilePicture: transactionsProvider
                                            .allTransactionsData[index]
                                            .counselorData!
                                            .profilePicture ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index]
                                        .counselorData!
                                        .profilePicture!,
                                id: transactionsProvider
                                            .allTransactionsData[index].id ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index].id!,
                                name: transactionsProvider
                                            .allTransactionsData[index]
                                            .counselorData!
                                            .name ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index]
                                        .counselorData!
                                        .name!,
                                topic: transactionsProvider
                                            .allTransactionsData[index]
                                            .counselorData!
                                            .topic ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index]
                                        .counselorData!
                                        .topic!,
                                consultationMethod: transactionsProvider
                                            .allTransactionsData[index]
                                            .consultationMethod ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index]
                                        .consultationMethod!,
                                date: tanggal,
                                time: transactionsProvider
                                            .allTransactionsData[index]
                                            .timeStart ==
                                        null
                                    ? '-'
                                    : transactionsProvider
                                        .allTransactionsData[index].timeStart!,
                                price: harga,
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
                                            height: 123,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          MyColor.neutralHigh,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 250,
                                                    height: 50,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: provider
                                                          .counselorRate.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Consumer<
                                                            TransactionViewModel>(
                                                          builder: (context,
                                                              transactionProvider,
                                                              _) {
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
                                                                  color: MyColor
                                                                      .warning,
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
                                                                  color: MyColor
                                                                      .neutralLow,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Consumer<
                                                          TransactionViewModel>(
                                                      builder: (context,
                                                          transactionProvider2,
                                                          _) {
                                                    if (transactionProvider2
                                                            .counselorRate[0] ==
                                                        true) {
                                                      return const SizedBox();
                                                    }
                                                    return Text(
                                                      'Please give us the rating',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                          Form(
                                            key: _formKey,
                                            child: SizedBox(
                                              height: 106,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Any words about your counseling or counselor?',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            MyColor.neutralHigh,
                                                      ),
                                                    ),
                                                    TextBox(
                                                      textEditingController:
                                                          _counselingCounselorController,
                                                      hintText:
                                                          'Type what you are thinking here ...',
                                                      last: true,
                                                      autoFocus: true,
                                                      currentFocus:
                                                          _counselingCounselorNode,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Wajib diisi";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Consumer<TransactionViewModel>(
                                              builder: (context,
                                                  transactionProvider, _) {
                                            var totalRate = transactionProvider
                                                .counselorRate
                                                .where(
                                              (element) => element == true,
                                            );
                                            return PrimaryButton(
                                              teks: 'Done',
                                              onPressed: transactionProvider
                                                          .counselorRate[0] ==
                                                      false
                                                  ? null
                                                  : () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        print(transactionProvider
                                                            .allTransactionsData[
                                                                index]
                                                            .id!);
                                                        print(totalRate.length);
                                                        print(
                                                            _counselingCounselorController
                                                                .text);
                                                        // transactionProvider
                                                        //     .createRateAndReviewCounselor(
                                                        //   transactionsId: transactionProvider
                                                        //               .allTransactionsData[
                                                        //                   index]
                                                        //               .id ==
                                                        //           null
                                                        //       ? ''
                                                        //       : transactionProvider
                                                        //           .allTransactionsData[
                                                        //               index]
                                                        //           .id!,
                                                        //   rating:
                                                        //       totalRate.length,
                                                        //   review:
                                                        //       _counselingCounselorController
                                                        //           .text,
                                                        // );
                                                        _counselingCounselorController
                                                            .clear();
                                                        Navigator.pop(context);
                                                        transactionProvider
                                                            .showAllTransactions(
                                                                statusOngoing:
                                                                    false);
                                                      }
                                                    },
                                            );
                                          }),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          });
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount:
                            transactionsProvider.allTransactionsData.length,
                      );
                    }
                  }
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
