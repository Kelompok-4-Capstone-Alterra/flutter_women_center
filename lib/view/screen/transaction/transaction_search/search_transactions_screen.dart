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
    provider.allTransactionsData.clear();
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
                      label: Text(provider.chipLabel[index]),
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
                  if (searchTransactionsProvider.state == MyState.loading) {
                    return const Loading();
                  } else {
                    if (searchTransactionsProvider
                        .allTransactionsData.isEmpty) {
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
                          if (searchTransactionsProvider
                                  .allTransactionsData[index].createdAt ==
                              null) {
                            tanggal = '-';
                          } else {
                            tanggal = DateFormatter.format(
                                searchTransactionsProvider
                                    .allTransactionsData[index].createdAt!);
                          }
                          //mata uang
                          if (searchTransactionsProvider
                                  .allTransactionsData[index].totalPrice ==
                              null) {
                            harga = '-';
                          } else {
                            harga = _moneyFormatter.formatRupiah(
                                searchTransactionsProvider
                                    .allTransactionsData[index].totalPrice!);
                          }
                          //show transaction card
                          if (searchTransactionsProvider
                                  .allTransactionsData[index].counselorData ==
                              null) {
                            return TransactionCard(
                              showButton: true,
                              labelButton: searchTransactionsProvider.value == 0
                                  ? 'Link'
                                  : 'Rate & Review',
                              profilePicture: '-',
                              id: searchTransactionsProvider
                                          .allTransactionsData[index].id ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index].id!,
                              name: '-',
                              topic: '-',
                              consultationMethod: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .consultationMethod ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index]
                                      .consultationMethod!,
                              date: tanggal,
                              time: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .timeStart ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index].timeStart!,
                              price: harga,
                              onPressed: null,
                            );
                          } else {
                            return TransactionCard(
                              showButton: searchTransactionsProvider.value == 0
                                  ? true
                                  : searchTransactionsProvider
                                              .allTransactionsData[index]
                                              .isReviewed ==
                                          false
                                      ? true
                                      : false,
                              labelButton: searchTransactionsProvider.value == 0
                                  ? 'Link'
                                  : 'Rate & Review',
                              profilePicture: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .counselorData!
                                          .profilePicture ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index]
                                      .counselorData!
                                      .profilePicture!,
                              id: searchTransactionsProvider
                                          .allTransactionsData[index].id ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index].id!,
                              name: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .counselorData!
                                          .name ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index]
                                      .counselorData!
                                      .name!,
                              topic: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .counselorData!
                                          .topic ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index]
                                      .counselorData!
                                      .topic!,
                              consultationMethod: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .consultationMethod ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index]
                                      .consultationMethod!,
                              date: tanggal,
                              time: searchTransactionsProvider
                                          .allTransactionsData[index]
                                          .timeStart ==
                                      null
                                  ? '-'
                                  : searchTransactionsProvider
                                      .allTransactionsData[index].timeStart!,
                              price: harga,
                              onPressed: searchTransactionsProvider.value == 0
                                  ? () async {
                                      final Uri _url = Uri.parse(
                                          searchTransactionsProvider
                                                      .allTransactionsData[
                                                          index]
                                                      .link ==
                                                  null
                                              ? '-'
                                              : searchTransactionsProvider
                                                  .allTransactionsData[index]
                                                  .link!);
                                      if (!await launchUrl(_url)) {
                                        throw Exception(
                                            'Could not launch $_url');
                                      }
                                    }
                                  : () {
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'How was your counselor?',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: MyColor
                                                              .neutralHigh,
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
                                                              .counselorRate
                                                              .length,
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
                                                                    onPressed:
                                                                        () {
                                                                      searchTransactionProvider
                                                                          .changeCounselorRate(
                                                                              index);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: 32,
                                                                      color: MyColor
                                                                          .warning,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      searchTransactionProvider
                                                                          .changeCounselorRate(
                                                                              index);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .star,
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
                                                                    .counselorRate[
                                                                0] ==
                                                            true) {
                                                          return const SizedBox();
                                                        }
                                                        return Text(
                                                          'Please give us the rating',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                MyColor.danger,
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                            color: MyColor
                                                                .neutralHigh,
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
                                              Consumer<
                                                      SearchTransactionsViewModel>(
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
                                                                  transactionsId: searchTransactionProvider
                                                                              .allTransactionsData[
                                                                                  index]
                                                                              .id ==
                                                                          null
                                                                      ? ''
                                                                      : searchTransactionProvider
                                                                          .allTransactionsData[
                                                                              index]
                                                                          .id!,
                                                                  rating:
                                                                      totalRate
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
                            .allTransactionsData.length,
                      );
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
