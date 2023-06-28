import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/buttons/floating_button.dart';
import 'package:capstone_project/utils/components/empty/empty.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/career/career_detail/career_detail_screen.dart';
import 'package:capstone_project/view/screen/career/career_detail/career_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    final provider = Provider.of<DetailCareerViewModel>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(
          MySize.screenWidth(context),
          double.maxFinite,
        ),
        home: false,
        judul: 'Career Information',
        searchField: true,
        tabBar: false,
        searchTextBox: SearchTextBox(
          keyboardType: TextInputType.text,
          textEditingController: _searchController,
          onChanged: (p0) {
            careerProvider.searchCareer(keyword: p0);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Consumer<CareerListViewModel>(
              builder: (context, value, child) {
                return Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(bottom: 8),
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
            Expanded(
              child: Consumer<CareerListViewModel>(
                builder: (context, value, child) {
                  if (value.state == MyState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (value.state == MyState.failed) {
                    return const Center(
                      child: Text('Error occurred while fetching careers.'),
                    );
                  } else if (value.careerList.isEmpty) {
                    return const Empty();
                  } else {
                    return ListView.builder(
                      itemCount: careerProvider.careerList.length,
                      itemBuilder: (context, index) {
                        final career = careerProvider.careerList[index];
                        return InkWell(
                          onTap: () async {
                            _searchFocusNode.unfocus();
                            await provider.fetchCareerById(
                              id: career.id!,
                            );
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CareerDetailScreen(
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
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
