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
    return Card(
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
                image: NetworkImage(image!),
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
                children: [
                  Text(
                    jobPosition ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    companyName ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15,
                        color: MyColor.neutralHigh,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        location ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: MyColor.neutralHigh,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.money, size: 15),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        moneyFormatter.formatRupiah(salary ?? 0),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: MyColor.primaryMain,
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
    );
  }
}
