
import 'package:flutter/material.dart';

import '../../my_color.dart';

class CustomPopupMenuButton extends StatefulWidget {
  final List<PopupMenuEntry<int>> Function(BuildContext) itemBuilder;
  final void Function(int)? onSelected;

  const CustomPopupMenuButton({
    super.key,
    required this.itemBuilder,
    required this.onSelected,
  });

  @override
  State<CustomPopupMenuButton> createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(-40, -30),
      icon: Icon(
        Icons.more_vert_outlined,
        color: MyColor.neutralMediumHigh,
      ),
      elevation: 0,
      position: PopupMenuPosition.under,
      color: MyColor.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: .25,
          color: MyColor.neutralMediumLow,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      onSelected: widget.onSelected,
      itemBuilder: widget.itemBuilder,
    );
  }
}
