import 'package:capstone_project/utils/components/empty/empty.dart';
import 'package:capstone_project/utils/components/loading/loading.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/transaction/transaction_search/search_transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/formarter/date_formater.dart';
import '../../../../utils/components/formarter/money_formater.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import '../../../../utils/my_color.dart';
import '../../../../utils/my_size.dart';
import '../widgets/transaction_card.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';

class SearchTransactionsScreen extends StatefulWidget {
  const SearchTransactionsScreen({super.key});

  static const String routeName = '/search_transactions_screen';

  @override
  State<SearchTransactionsScreen> createState() =>
      _SearchTransactionsScreenState();
}

class _SearchTransactionsScreenState extends State<SearchTransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _counselingCounselorController =
      TextEditingController();
  final FocusNode _counselingCounselorNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String tanggal;
  late String harga;
  final MoneyFormatter _moneyFormatter = MoneyFormatter();

  late final SearchTransactionsViewModel provider;

  @override
  void initState() {
    provider = Provider.of<SearchTransactionsViewModel>(context, listen: false);
    provider.allTransactionsDataOngoing.clear();
    provider.allTransactionsDataHistory.clear();
    provider.value = null;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _counselingCounselorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        home: false,
        searchField: true,
        tabBar: false,
        judul: 'Search Transactions',
        searchTextBox: SearchTextBox(
          autoFocus: true,
          textEditingController: _searchController,
          onChanged: (value) {
            if (provider.value == 0) {
              provider.showAllTransactionsBySearch(
                statusOngoing: true,
                search: value,
              );
            } else if (provider.value == 1) {
              provider.showAllTransactionsBySearch(
                statusOngoing: false,
                search: value,
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                2,
                (int index) {
                  return Consumer<SearchTransactionsViewModel>(
                      builder: (context, searchTransactionProvider, _) {
                    return ChoiceChip(
                      label: Text(searchTransactionProvider.chipLabel[index]),
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      selected: searchTransactionProvider.value == index,
                      onSelected: (bool selected) {
                        searchTransactionProvider.changeChoiceChip(index);
                        if (searchTransactionProvider.value == 0) {
                          searchTransactionProvider.showAllTransactionsBySearch(
                            statusOngoing: true,
                            search: _searchController.text,
                          );
                        } else {
                          searchTransactionProvider.showAllTransactionsBySearch(
                            statusOngoing: false,
                            search: _searchController.text,
                          );
                        }
                      },
                    );
                  });
                },
              ).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            Flexible(
              child: RefreshIndicator(
                strokeWidth: 2,
                color: MyColor.primaryMain,
                onRefresh: () {
                  _searchController.clear();
                  if (provider.value == 0) {
                    return provider.showAllTransactionsBySearch(
                        statusOngoing: true, search: _searchController.text);
                  } else {
                    return provider.showAllTransactionsBySearch(
                        statusOngoing: false, search: _searchController.text);
                  }
                },
                child: Consumer<SearchTransactionsViewModel>(
                    builder: (context, searchTransactionsProvider, _) {
                  print(searchTransactionsProvider.value);
                  if (searchTransactionsProvider.state == MyState.loading) {
                    return const Loading();
                  } else {
                    if (searchTransactionsProvider.value == 0) {
                      if (searchTransactionsProvider
                          .allTransactionsDataOngoing.isEmpty) {
                        return const Empty();
                      } else {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            //tanggal
                            if (searchTransactionsProvider
                                    .allTransactionsDataOngoing[index]
                                    .createdAt ==
                                null) {
                              tanggal = '-';
                            } else {
                              tanggal = DateFormatter.format(
                                  searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .createdAt!);
                            }
                            //mata uang
                            if (searchTransactionsProvider
                                    .allTransactionsDataOngoing[index]
                                    .totalPrice ==
                                null) {
                              harga = '-';
                            } else {
                              harga = _moneyFormatter.formatRupiah(
                                  searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .totalPrice!);
                            }
                            //show transaction card
                            if (searchTransactionsProvider
                                    .allTransactionsDataOngoing[index]
                                    .counselorData ==
                                null) {
                              return TransactionCard(
                                showButton: true,
                                labelButton: 'Link',
                                profilePicture: '-',
                                id: searchTransactionsProvider
                                    .allTransactionsDataOngoing[index].id!,
                                name: '-',
                                topic: '-',
                                consultationMethod: searchTransactionsProvider
                                    .allTransactionsDataOngoing[index]
                                    .consultationMethod!,
                                date: tanggal,
                                time: searchTransactionsProvider
                                    .allTransactionsDataOngoing[index]
                                    .timeStart!,
                                price: harga,
                                onPressed: null,
                              );
                            } else {
                              return TransactionCard(
                                  showButton: true,
                                  labelButton: 'Rate & Review',
                                  profilePicture: searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .counselorData!
                                      .profilePicture!,
                                  id: searchTransactionsProvider
                                      .allTransactionsDataOngoing[index].id!,
                                  name: searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .counselorData!
                                      .name!,
                                  topic: searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .counselorData!
                                      .topic!,
                                  consultationMethod: searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .consultationMethod!,
                                  date: tanggal,
                                  time: searchTransactionsProvider
                                      .allTransactionsDataOngoing[index]
                                      .timeStart!,
                                  price: harga,
                                  onPressed: () async {
                                    searchTransactionsProvider.linkToCounseling(
                                      userId: searchTransactionsProvider
                                          .allTransactionsDataOngoing[index]
                                          .userId,
                                      transactionId: searchTransactionsProvider
                                          .allTransactionsDataOngoing[index].id,
                                    );
                                    // final Uri _url = Uri.parse(
                                    //     searchTransactionsProvider
                                    //                 .allTransactionsData[
                                    //                     index]
                                    //                 .link ==
                                    //             null
                                    //         ? '-'
                                    //         : searchTransactionsProvider
                                    //             .allTransactionsData[index]
                                    //             .link!);
                                    // if (!await launchUrl(_url)) {
                                    //   throw Exception(
                                    //       'Could not launch $_url');
                                    // }
                                  });
                            }
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: searchTransactionsProvider
                              .allTransactionsDataOngoing.length,
                        );
                      }
                    } else {
                      print(searchTransactionsProvider
                          .allTransactionsDataHistory);
                      print('object');
                      if (searchTransactionsProvider
                          .allTransactionsDataHistory.isEmpty) {
                        return const Empty();
                      } else {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            //tanggal
                            if (searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .createdAt ==
                                null) {
                              tanggal = '-';
                            } else {
                              tanggal = DateFormatter.format(
                                  searchTransactionsProvider
                                      .allTransactionsDataHistory[index]
                                      .createdAt!);
                            }
                            //mata uang
                            if (searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .totalPrice ==
                                null) {
                              harga = '-';
                            } else {
                              harga = _moneyFormatter.formatRupiah(
                                  searchTransactionsProvider
                                      .allTransactionsDataHistory[index]
                                      .totalPrice!);
                            }
                            //show transaction card
                            if (searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .counselorData ==
                                null) {
                              return TransactionCard(
                                showButton: true,
                                labelButton: 'Rate & Review',
                                profilePicture: '-',
                                id: searchTransactionsProvider
                                    .allTransactionsDataHistory[index].id!,
                                name: '-',
                                topic: '-',
                                consultationMethod: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .consultationMethod!,
                                date: tanggal,
                                time: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .timeStart!,
                                price: harga,
                                onPressed: null,
                              );
                            } else {
                              return TransactionCard(
                                showButton: searchTransactionsProvider
                                            .allTransactionsDataHistory[index]
                                            .isReviewed ==
                                        false
                                    ? true
                                    : false,
                                labelButton: 'Rate & Review',
                                profilePicture: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .counselorData!
                                    .profilePicture!,
                                id: searchTransactionsProvider
                                    .allTransactionsDataHistory[index].id!,
                                name: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .counselorData!
                                    .name!,
                                topic: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .counselorData!
                                    .topic!,
                                consultationMethod: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .consultationMethod!,
                                date: tanggal,
                                time: searchTransactionsProvider
                                    .allTransactionsDataHistory[index]
                                    .timeStart!,
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
                                            height: 103,
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
                                                            SearchTransactionsViewModel>(
                                                          builder: (context,
                                                              searchTransactionProvider,
                                                              _) {
                                                            if (searchTransactionProvider
                                                                        .counselorRate[
                                                                    index] ==
                                                                true) {
                                                              return IconButton(
                                                                onPressed: () {
                                                                  searchTransactionProvider
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
                                                                  searchTransactionProvider
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
                                                          SearchTransactionsViewModel>(
                                                      builder: (context,
                                                          searchTransactionProvider,
                                                          _) {
                                                    if (searchTransactionProvider
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
                                                          return "review is required";
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
                                          Consumer<SearchTransactionsViewModel>(
                                              builder: (context,
                                                  searchTransactionProvider,
                                                  _) {
                                            var totalRate =
                                                searchTransactionProvider
                                                    .counselorRate
                                                    .where(
                                              (element) => element == true,
                                            );
                                            return PrimaryButton(
                                              teks: 'Done',
                                              onPressed:
                                                  searchTransactionProvider
                                                                  .counselorRate[
                                                              0] ==
                                                          false
                                                      ? null
                                                      : () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _counselingCounselorController
                                                                .clear();
                                                            searchTransactionProvider
                                                                .createRateAndReviewCounselor(
                                                              counselorId:
                                                                  searchTransactionProvider
                                                                      .allTransactionsDataHistory[
                                                                          index]
                                                                      .counselorId!,
                                                              transactionsId:
                                                                  searchTransactionProvider
                                                                      .allTransactionsDataHistory[
                                                                          index]
                                                                      .id!,
                                                              rating: totalRate
                                                                  .length,
                                                              review:
                                                                  _counselingCounselorController
                                                                      .text,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            searchTransactionProvider
                                                                .showAllTransactionsBySearch(
                                                              statusOngoing:
                                                                  false,
                                                              search: '',
                                                            );
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
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: searchTransactionsProvider
                              .allTransactionsDataHistory.length,
                        );
                      }
                    }
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
