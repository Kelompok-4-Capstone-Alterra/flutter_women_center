import 'package:flutter/material.dart';

import '../../../../utils/components/buttons/text_action_button.dart';
import '../../../../utils/my_color.dart';

class TransactionBottomSheet extends StatefulWidget {
  final String judul;
  final List<Widget> isi;

  const TransactionBottomSheet({
    super.key,
    required this.judul,
    required this.isi,
  });

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  @override
  Widget build(BuildContext context) {
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
                    'Give Rate & Review',
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: widget.isi,
            ),
          ),
        ],
      ),
    );
  }
}
