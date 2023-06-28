import 'package:capstone_project/utils/components/buttons/primary_button.dart';

import 'package:capstone_project/utils/components/loading/loading.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/components/text_box/text_box.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_post/article_list_post_view_model.dart';
import 'package:capstone_project/view/screen/article/save_content/save_content_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveContent extends StatefulWidget {
  final String articleId;
  const SaveContent({super.key, required this.articleId});

  @override
  State<SaveContent> createState() => _SaveContentState();
}

class _SaveContentState extends State<SaveContent> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<SaveContentProvider>(context, listen: false);
      provider.showAllReadingList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController listNameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final GlobalKey<FormState> addReadingListFormKey = GlobalKey<FormState>();
    final FocusNode listNameNode = FocusNode();
    final FocusNode descriptionNode = FocusNode();
    final saveContentProvider =
        Provider.of<SaveContentProvider>(context, listen: false);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                    isDismissible: false,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return CustomBottomSheetBuilder(
                        tinggi: MediaQuery.of(context).size.height * 0.8,
                        header: true,
                        judul: 'Create New List',
                        cancelEvent: () {
                          listNameController.clear();
                          descriptionController.clear();
                          Navigator.pop(context);
                        },
                        isi: [
                          Form(
                            key: addReadingListFormKey,
                            child: SizedBox(
                              height: 680,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'List Name',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.neutralHigh,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBox(
                                    textEditingController: listNameController,
                                    hintText:
                                        'Ex : How to heal my traumatized inner child',
                                    currentFocus: listNameNode,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Wajib diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.neutralHigh,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBox(
                                    textEditingController:
                                        descriptionController,
                                    last: true,
                                    hintText: 'Ex : This is an important list',
                                    currentFocus: descriptionNode,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Wajib diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Consumer<SaveContentProvider>(
                                      builder: (context, savedProvider, _) {
                                    return PrimaryButton(
                                      teks: 'Add',
                                      onPressed: () async {
                                        if (addReadingListFormKey.currentState!
                                            .validate()) {
                                          final provider =
                                              Provider.of<SaveContentProvider>(
                                                  context,
                                                  listen: false);
                                          await provider.createReadingList(
                                            context,
                                            name: listNameController.text,
                                            description:
                                                descriptionController.text,
                                          );

                                          listNameController.clear();
                                          descriptionController.clear();

                                          await savedProvider
                                              .refreshReadingList();
                                        }
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).then((value) {
                  Provider.of<SaveContentProvider>(context, listen: false)
                      .showAllReadingList();
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Create new list ...",
                style: TextStyle(fontSize: 16, color: MyColor.secondaryPressed),
              ),
            ),
          ),
          Expanded(
            child: Consumer<SaveContentProvider>(
              builder: (context, provider, _) {
                if (provider.myState == MyState.loading) {
                  return const Loading();
                } else if (provider.myState == MyState.loaded &&
                    provider.readingList.isEmpty) {
                  return const Center(
                    child: Text('No Reading List Yet'),
                  ); // Tampilkan loading widget jika masih dalam proses loading
                } else if (provider.myState == MyState.loaded &&
                    provider.readingList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: provider.readingList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          await provider.toggleCheck(index);
                          provider.setSelectedReadingListId(
                              provider.readingList[index].id ?? '');
                        },
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          provider.readingList[index].name ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: provider.isItemChecked(index)
                            ? Icon(Icons.check, color: MyColor.primaryMain)
                            : null,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Failed to load data'),
                  ); // Tampilkan pesan gagal jika gagal memuat data
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: PrimaryButton(
              teks: 'Save',
              onPressed: () {
                Provider.of<ArticleListPostProvider>(context, listen: false)
                    .toggleArticleSaved(widget.articleId, true);
                saveContentProvider.saveToReadingList(widget.articleId,
                    saveContentProvider.selectedReadingListId);
                saveContentProvider.clearCheckedItems();
                saveContentProvider.isButtonPressed.value = true;
                final detailProvider =
                    Provider.of<SavedViewModel>(context, listen: false);
                detailProvider.showReadingListSortByOldestOrNewest(
                    sortByOldest: false);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
