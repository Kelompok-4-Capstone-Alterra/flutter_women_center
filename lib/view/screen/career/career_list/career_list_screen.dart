import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/components/buttons/floating_button.dart';
import '../../../../../utils/my_color.dart';
import '../../../../../utils/state/finite_state.dart';
import '../../../../utils/components/text_box/search_text_box.dart';
import '../career_detail/career_detail_screen.dart';
import '../career_detail/career_detail_view_model.dart';
import 'career_list_view_model.dart';
import 'widget/career_info_widget.dart';
import 'widget/option_sort_by_widget.dart';

class CareerListScreen extends StatefulWidget {
  const CareerListScreen({super.key});

  static const String routeName = '/career';

  @override
  State<CareerListScreen> createState() => _CareerListScreenState();
}

class _CareerListScreenState extends State<CareerListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FocusNode _searchFocusNode = FocusNode();
  late CareerListViewModel careerProvider;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    careerProvider = Provider.of<CareerListViewModel>(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      careerProvider.fetchAllCareer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late String statusList = 'Newest';

    final DetailCareerViewModel provider =
        Provider.of<DetailCareerViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Career Information',
          style: TextStyle(
            color: MyColor.neutralHigh,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Form(
              key: _formKey,
              child: SearchTextBox(
                keyboardType: TextInputType.text,
                textEditingController: _searchController,
                onChanged: (value) {
                  careerProvider.searchCareer(keyword: value);
                },
                focusNode: _searchFocusNode,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Consumer<CareerListViewModel>(
                      builder: (context, value, child) {
                        return Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            statusList,
                            style: TextStyle(
                              fontSize: 12,
                              color: MyColor.neutralMediumLow,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                    Consumer<CareerListViewModel>(
                      builder: (context, value, child) {
                        if (value.state == MyState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (value.state == MyState.failed) {
                          return const Center(
                            child:
                                Text('Error occurred while fetching careers.'),
                          );
                        } else if (value.careerList.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
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
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: careerProvider.careerList.length,
                            itemBuilder: (context, index) {
                              final career = careerProvider.careerList[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      _searchFocusNode.unfocus();
                                      await provider.fetchCareerById(
                                        id: career.id!,
                                      );
                                      if (context.mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CareerDetailScreen(
                                              id: career.id!,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: CareerInfoWidget(
                                      image: career.image,
                                      jobPosition: career.jobPosition,
                                      companyName: career.companyName,
                                      location: career.location,
                                      salary: career.salary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return OptionSortByWidget(
                sortBySaveEvent: () {
                  Navigator.pop(context);
                  if (careerProvider.newestCheckStatus) {
                    careerProvider.saveSortByNewest();
                    statusList = 'Newest';
                  } else {
                    careerProvider.saveSortByHighestSalary();
                    statusList = 'Highest Salary';
                  }
                  careerProvider.fetchCareerSortBy(
                    sortByCareer: careerProvider.sortingByNewest,
                  );
                },
              );
            },
          );
        },
        teks: 'Sort By',
        widget: const Icon(Icons.sort),
      ),
    );
  }
}
