import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final bool showButton;
  final String labelButton;
  final void Function()? onPressed;
  final String profilePicture;
  final String id;
  final String name;
  final String topic;
  final String consultationMethod;
  final String date;
  final String time;
  final String price;

  const TransactionCard({
    super.key,
    required this.showButton,
    required this.labelButton,
    required this.profilePicture,
    required this.id,
    required this.name,
    required this.topic,
    required this.consultationMethod,
    required this.date,
    required this.time,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: showButton == true ? 196 : 144,
      child: Card(
        elevation: 0.0,
        color: MyColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: MyColor.neutralLow,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 72,
              width: 64,
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 18),
              child: !profilePicture.startsWith('https://')
                  ? const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(profilePicture),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              id,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMedium,
                              ),
                            ),
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColor.neutralHigh,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    topic,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.neutralMedium,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    consultationMethod,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.neutralMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '$date, $time',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: MyColor.neutralMediumLow,
                              ),
                            ),
                            Text(
                              price,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColor.primaryMain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    showButton == true
                        ? const SizedBox(
                            height: 16,
                          )
                        : const SizedBox(),
                    showButton == true
                        ? PrimaryButton(
                            teks: labelButton,
                            onPressed: onPressed,
                            customHeight: 44,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
