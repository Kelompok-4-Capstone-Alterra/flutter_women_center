import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/career/career_list/career_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/components/buttons/text_action_button.dart';

class OptionSortByWidget extends StatefulWidget {
  final void Function()? sortBySaveEvent;

  const OptionSortByWidget({
    required this.sortBySaveEvent,
    super.key,
  });

  @override
  State<OptionSortByWidget> createState() => _OptionSortByWidgetState();
}

class _OptionSortByWidgetState extends State<OptionSortByWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CareerListViewModel>(context, listen: false);
    provider.newestCheckStatus = provider.sortingByNewest;
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
              child: Consumer<CareerListViewModel>(
                  builder: (context, savedProvider, _) {
                return ListView(
                  children: [
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
                            savedProvider.newestCheckStatus == true
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
                        savedProvider.checkHighestSalary();
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Highest Salary',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralHigh,
                              ),
                            ),
                            savedProvider.newestCheckStatus == false
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
                      onPressed: widget.sortBySaveEvent,
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
