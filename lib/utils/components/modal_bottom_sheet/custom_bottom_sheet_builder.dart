import 'package:flutter/material.dart';
import '../../../../utils/components/buttons/text_action_button.dart';
import '../../../../utils/my_color.dart';

class CustomBottomSheetBuilder extends StatefulWidget {
  final String? judul;
  final List<Widget> isi;
  final double tinggi;
  final bool header;

  const CustomBottomSheetBuilder({
    super.key,
    required this.tinggi,
    this.judul,
    required this.isi,
    required this.header,
  });

  @override
  State<CustomBottomSheetBuilder> createState() => _CustomBottomSheetBuilder();
}

class _CustomBottomSheetBuilder extends State<CustomBottomSheetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.tinggi - kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          widget.header == true
              ? Container(
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
                          widget.judul == null ? '' : widget.judul!,
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
                )
              : const SizedBox(
                  height: 48,
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: widget.isi,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
