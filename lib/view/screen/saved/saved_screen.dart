import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button_icon.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_screen.dart';
import 'package:capstone_project/view/screen/saved/widgets/saved_card.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  static const String routeName = '/saved_screen';

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final TextEditingController _listNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _listNameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final TextEditingController _editListNameController = TextEditingController();
  final TextEditingController _editDescriptionController =
      TextEditingController();
  final FocusNode _editListNameNode = FocusNode();
  final FocusNode _editDescriptionNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Reading List',
        home: false,
        searchField: false,
        tabBar: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PrimaryButtonIcon(
              widget: const Icon(Icons.add),
              teks: 'New List',
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheetBuilder(
                      tinggi: 680,
                      header: true,
                      judul: 'Create New List',
                      isi: [
                        SizedBox(
                          height: 72,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'List Name',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.neutralHigh,
                                ),
                              ),
                              TextBox(
                                textEditingController: _listNameController,
                                hintText:
                                    'Ex : How to heal my traumatized inner child',
                                currentFocus: _listNameNode,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 72,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Description (optional)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.neutralHigh,
                                ),
                              ),
                              TextBox(
                                textEditingController: _descriptionController,
                                last: true,
                                hintText: 'Ex : This is an important list',
                                currentFocus: _descriptionNode,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryButton(
                          teks: 'Add',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              customHeight: 36,
              customWidth: 119,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailReadingListScreen.routeName);
              },
              child: SavedCard(
                editListNameTextEditingController: _editListNameController,
                editDescriptionTextEditingController:
                    _editDescriptionController,
                editListNameFocusNode: _editListNameNode,
                editDescriptionFocusNode: _editDescriptionNode,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }
}
