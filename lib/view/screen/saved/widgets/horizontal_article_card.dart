import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class HorizontalArticleCard extends StatelessWidget {
  final String urlGambarArtikel;
  final String kategoriArtikel;
  final String judulArtikel;

  const HorizontalArticleCard({
    super.key,
    required this.urlGambarArtikel,
    required this.kategoriArtikel,
    required this.judulArtikel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 157,
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: MyColor.neutralLow, width: .5),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            child: !urlGambarArtikel.startsWith('https://')
                ? const SizedBox(
                    height: 114,
                    width: double.infinity,
                    child: Placeholder(),
                  )
                : Image.network(
                    urlGambarArtikel,
                    fit: BoxFit.fill,
                    height: 114,
                  ),
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kategoriArtikel,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralMediumLow,
                    ),
                  ),
                  Text(
                    judulArtikel,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
