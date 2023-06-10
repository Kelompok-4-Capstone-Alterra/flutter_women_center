import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:flutter/material.dart';

import '../../../../utils/components/buttons/floating_button.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import '../../../../utils/my_color.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
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
            SearchTextBox(
              keyboardType: TextInputType.text,
              textEditingController: _searchController,
            ),
            const SizedBox(
              height: 32,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            const Expanded(
              child: CareerInfoWidget(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CustomBottomSheetBuilder(
                tinggi: MediaQuery.of(context).size.height * 0.80,
                header: true,
                judul: 'Sort By',
                isi: const [
                  OptionSortBy(),
                ],
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
