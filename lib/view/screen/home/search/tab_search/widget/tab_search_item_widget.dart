import 'package:flutter/material.dart';

import '../../../../../../utils/my_color.dart';

class TabSearchItem extends StatelessWidget {
  final String imageUrl;
  final List<Widget> isi;
  final Widget? extraWidget;
  final void Function()? onTapAction;

  const TabSearchItem({
    super.key,
    required this.imageUrl,
    required this.isi,
    this.extraWidget,
    this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child: Card(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(3),
            ),
            side: BorderSide(
              color: MyColor.neutralLow,
              width: .5,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 128,
              width: 135,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(3),
                ),
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: MyColor.danger,
                        ),
                        Text(
                          'Image Error',
                          style: TextStyle(
                            color: MyColor.danger,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: isi,
                ),
              ),
            ),
            extraWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
    ;
  }
}
