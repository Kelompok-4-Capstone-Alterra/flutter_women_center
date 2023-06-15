import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/components/buttons/text_action_button.dart';

class ReadingListSortByBottomSheetBuilder extends StatefulWidget {
  const ReadingListSortByBottomSheetBuilder({super.key});

  @override
  State<ReadingListSortByBottomSheetBuilder> createState() =>
      _ReadingListSortByBottomSheetBuilderState();
}

class _ReadingListSortByBottomSheetBuilderState
    extends State<ReadingListSortByBottomSheetBuilder> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SavedViewModel>(context, listen: false);
    provider.oldestCheckStatus = provider.sortByOldest;
    return Container(
      height: 680,
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: .5,
                  color: MyColor.neutralLow,
                ),
              ),
            ),
            height: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort By',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  TextActionButton(
                    teks: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<SavedViewModel>(
                  builder: (context, savedProvider, _) {
                return ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        savedProvider.checkOldest();
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Oldest',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralHigh,
                              ),
                            ),
                            savedProvider.oldestCheckStatus == true
                                ? Icon(
                                    Icons.check,
                                    color: MyColor.primaryMain,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        savedProvider.checkNewest();
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Newest',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralHigh,
                              ),
                            ),
                            savedProvider.oldestCheckStatus == false
                                ? Icon(
                                    Icons.check,
                                    color: MyColor.primaryMain,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      teks: 'Save',
                      onPressed: () {
                        Navigator.pop(context);
                        if (savedProvider.oldestCheckStatus == true) {
                          savedProvider.saveSortByOldest();
                        } else {
                          savedProvider.saveSortByNewest();
                        }
                      },
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
