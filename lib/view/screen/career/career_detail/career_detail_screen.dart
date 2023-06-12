import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import '../../../../utils/components/buttons/outline_button.dart';
import '../../../../utils/my_color.dart';

class CareerDetailScreen extends StatefulWidget {
  const CareerDetailScreen({super.key});

  static const String routeName = '/careerDetail';

  @override
  State<CareerDetailScreen> createState() => _CareerDetailScreenState();
}

class _CareerDetailScreenState extends State<CareerDetailScreen> {
  final Map<String, dynamic> requirementJob = {
    'persyaratan': [
      {
        'icon': 'assets/icons/location_on.png',
        'text': 'Kunigan, Jakarta Selatan',
      },
      {
        'icon': 'assets/icons/timer.png',
        'text': 'Min. Pengalaman 1 Tahun',
      },
      {
        'icon': 'assets/icons/work.png',
        'text': 'Full Time',
      },
      {
        'icon': 'assets/icons/menu_book.png',
        'text': 'S1',
      },
    ],
    'description':
        'Amara Jaya Sejahtera adalah perusahaan yang bergerak di bidang distribusi produk kecantikan dan kesehatan. Kami berkomitmen untuk memberikan produk berkualitas tinggi kepada pelanggan kami di seluruh Indonesia. Saat ini, kami sedang mencari seorang Asisten Administrasi yang terampil dan bersemangat untuk bergabung dengan tim kami.\n\nAsisten administrasi akan bekerja di kantor setiap hari senin sampai dengan jumat jam 09.00 - 16.00. Asisten administrasi akan bertanggung jawab memahami product knowledge dengan baik, menjalin hubungan baik dengan pelanggan dan melakukan research.',
    'requirement': [
      'Wanita Max 30 tahun',
      'Berdomisili Jabodetabek',
      'Mampu berkomunikasi dengan baik secara lisan ataupun tertulis',
      'Lancar berbahasa inggris',
    ],
    'apply':
        'Kirim CV, Fotocopy KTP dan Sertifikat Vaksin ke :\nptamarajaya@gmail.com\nFile dikirimkan dalam bentuk PDF dan Subjek "Nama_Posisi"',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Career Information',
          style: TextStyle(
            color: MyColor.neutralHigh,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 224,
                    child: Image.network(
                      'https://picsum.photos/200',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '20 April 2023',
                      style: TextStyle(
                        color: MyColor.neutralMediumLow,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Asisten Administrasi',
                      style: TextStyle(
                        color: MyColor.neutralHigh,
                        fontSize: 16,
                        letterSpacing: 0.15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'PT Amara Jaya Sejahtera',
                      style: TextStyle(
                        color: MyColor.neutralHigh,
                        fontSize: 12,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Rp 3,500,000 - 5,500,000',
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
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 8,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 12,
                    children: List<Widget>.from(
                        requirementJob['persyaratan']!.map((requirement) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            requirement['icon']!,
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            requirement['text']!,
                            style: TextStyle(
                              color: MyColor.neutralHigh,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    })),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColor.neutralLow.withOpacity(0.7),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  color: MyColor.neutralHigh,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              requirementJob['description'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 12,
                                color: MyColor.neutralHigh,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColor.neutralLow.withOpacity(0.7),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Requirements',
                                style: TextStyle(
                                  color: MyColor.neutralHigh,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (requirementJob['requirement']
                                          as List<dynamic>?)
                                      ?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                final requirement =
                                    requirementJob['requirement']?[index] ?? '';
                                return Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: MyColor.neutralHigh,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        requirement,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: MyColor.neutralHigh,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColor.neutralLow.withOpacity(0.7),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'How to apply?',
                                style: TextStyle(
                                  color: MyColor.neutralHigh,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              requirementJob['apply'] ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                color: MyColor.neutralHigh,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              teks: 'Apply Now',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xffFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      title: Center(
                        child: Text(
                          'Do you want to apply for this career??',
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColor.neutralHigh,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        const SizedBox(height: 16),
                        PrimaryButton(
                          teks: 'Yes, Apply Now',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        OutlineButton(
                          teks: 'Maybe Later',
                          customBackgroundColor: MyColor.white,
                          customTextColor: MyColor.primaryMain,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
