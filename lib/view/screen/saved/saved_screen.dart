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
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:capstone_project/view/screen/saved/widgets/saved_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _listNameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SavedViewModel>(context, listen: false);
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
                    provider.buttonIsActive == false;
                    return CustomBottomSheetBuilder(
                      tinggi: 680,
                      header: true,
                      judul: 'Create New List',
                      isi: [
                        Form(
                          key: _formKey,
                          child: SizedBox(
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
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      provider.deactivateButton();
                                    } else {
                                      provider.activateButton();
                                    }
                                  },
                                ),
                              ],
                            ),
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
                        Consumer<SavedViewModel>(
                            builder: (context, savedProvider, _) {
                          return PrimaryButton(
                            teks: 'Add',
                            onPressed: savedProvider.buttonIsActive == false
                                ? null
                                : () {
                                    savedProvider
                                        .newList(_listNameController.text);
                                    _listNameController.clear();
                                    _descriptionController.clear();
                                    savedProvider.buttonIsActive = false;

                                    Navigator.pop(context);
                                  },
                          );
                        }),
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
        child: Consumer<SavedViewModel>(builder: (context, savedProvider, _) {
          if (savedProvider.readingList.isEmpty) {
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
              itemCount: provider.readingList.length,
              itemBuilder: (context, index) {
                return Consumer<SavedViewModel>(
                    builder: (context, savedProvider, _) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, DetailReadingListScreen.routeName);
                    },
                    child: SavedCard(
                      judulList: savedProvider.readingList[index],
                      editListNameTextEditingController:
                          _editListNameController,
                      editDescriptionTextEditingController:
                          _editDescriptionController,
                      editListNameFocusNode: _editListNameNode,
                      editDescriptionFocusNode: _editDescriptionNode,
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
            );
          }
        }),
      ),
    );
  }
}
