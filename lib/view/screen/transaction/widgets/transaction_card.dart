import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final bool showButton;
  final String labelButton;
  final void Function()? onPressed;

  const TransactionCard({
    super.key,
    required this.showButton,
    required this.labelButton,
    this.onPressed,
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
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
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
                              '1234567',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMedium,
                              ),
                            ),
                            Text(
                              'John Doe',
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
                                    'Self Development',
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
                                    'Video Call',
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
                              '20 May 2023, 09:00',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: MyColor.neutralMediumLow,
                              ),
                            ),
                            Text(
                              'Rp 125,000',
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
