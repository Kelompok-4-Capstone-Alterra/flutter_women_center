import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/buttons/floating_button.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/counselor_detail/counselor_detail_screen.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_rating/star_rating.dart';

class CounselorListScreen extends StatefulWidget {
  static const String routeName = '/counselor-list';

  const CounselorListScreen({super.key});

  @override
  State<CounselorListScreen> createState() => _CounselorListScreenState();
}

class _CounselorListScreenState extends State<CounselorListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<CounselorListViewModel>(context, listen: false);
      provider.filterHighestRating();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MoneyFormatter moneyFormatter = MoneyFormatter();
    final provider =
        Provider.of<CounselorListViewModel>(context, listen: false);
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.screenWidth(context), double.maxFinite),
        home: false,
        judul: 'Counselor',
        searchField: true,
        tabBar: false,
        searchTextBox: SearchTextBox(
          textEditingController: searchController,
          onChanged: (value) {
            provider.filterByName(value);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Consumer<CounselorListViewModel>(
                  builder: (context, provider, _) {
                return Text(
                  provider.sortValue,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                );
              }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Consumer<CounselorListViewModel>(
                builder: (context, provider, _) {
                  switch (provider.myState) {
                    case MyState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case MyState.loaded:
                      return ListView.builder(
                        itemCount: provider.counselorList.length,
                        shrinkWrap: true,
                        // add spacing between cards
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CounselorDetailScreen(
                                    id: provider.counselorList[index]['id'],
                                  );
                                },
                              ));
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              margin: const EdgeInsets.only(bottom: 8),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: double.infinity,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      padding: const EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 8,
                                          right: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.counselorList[index]
                                                ['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            provider.counselorList[index]
                                                ['specialist'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          StarRating(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            length: 5,
                                            rating: provider
                                                .counselorList[index]['rating']
                                                .toDouble(),
                                            between: 2,
                                            starSize: 20,
                                            color: MyColor.warning,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            moneyFormatter.formatRupiah(provider
                                                .counselorList[index]['price']),
                                            style: const TextStyle(
                                                color: Color(0xFFAF1582),
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    default:
                      return const Text('No Data Found');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 130,
        child: FloatingButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                useRootNavigator: true,
                context: context,
                builder: (BuildContext context) {
                  return CustomBottomSheetBuilder(
                    tinggi: MediaQuery.of(context).size.height * 0.8,
                    isi: [
                      Consumer<CounselorListViewModel>(
                          builder: (context, provider, _) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                provider.filterHighestRating();
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Highest Rating'),
                                  (provider.sortValue == 'Highest Rating')
                                      ? Icon(Icons.check,
                                          color: MyColor.primaryMain)
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            InkWell(
                              onTap: () {
                                provider.filterHighestPrice();
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Highest Price'),
                                  (provider.sortValue == 'Highest Price')
                                      ? Icon(Icons.check,
                                          color: MyColor.primaryMain)
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            InkWell(
                              onTap: () {
                                provider.filterLowestPrice();
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Lowest Price'),
                                  (provider.sortValue == 'Lowest Price')
                                      ? Icon(Icons.check,
                                          color: MyColor.primaryMain)
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                    header: true,
                    judul: 'Sort By',
                  );
                });
          },
          teks: 'Sort By',
          widget: const Icon(Icons.sort),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
