import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/components/formarter/money_formater.dart';

class CareerInfoWidget extends StatelessWidget {
  const CareerInfoWidget(
      {Key? key,
      this.image,
      this.jobPosition,
      this.companyName,
      this.location,
      this.salary})
      : super(key: key);

  final String? image;
  final String? jobPosition;
  final String? companyName;
  final String? location;
  final int? salary;

  @override
  Widget build(BuildContext context) {
    final MoneyFormatter moneyFormatter = MoneyFormatter();
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColor.neutralLow.withOpacity(0.7),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                height: 120,
                width: 150,
                image: NetworkImage(
                  image!,
                ),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 32,
                      ),
                      Text(
                        'Image Error',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobPosition ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: MyColor.neutralHigh,
                          fontSize: 12,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        companyName ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: MyColor.neutralMediumHigh,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.place,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            location ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: MyColor.neutralHigh,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.money,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            moneyFormatter.formatRupiah(salary ?? 0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: MyColor.primaryMain,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
