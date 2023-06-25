import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button_icon_text.dart';
import 'package:capstone_project/view/screen/career/career_detail/widget/info_career_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/components/buttons/outline_button.dart';
import '../../../../../utils/my_color.dart';
import '../../../../utils/components/formarter/money_formater.dart';
import '../../auth/login/login_screen.dart';
import 'career_detail_view_model.dart';

class CareerDetailScreen extends StatefulWidget {
  const CareerDetailScreen({super.key, required this.id});

  static const String routeName = '/careerDetail';
  final String id;

  @override
  State<CareerDetailScreen> createState() => _CareerDetailScreenState();
}

class _CareerDetailScreenState extends State<CareerDetailScreen> {
  late final DetailCareerViewModel provider;

  @override
  void initState() {
    provider = Provider.of<DetailCareerViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchCareerById(
        id: widget.id,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MoneyFormatter moneyFormatter = MoneyFormatter();
    final String formattedDate = provider.getCurrentDate(
      date: provider.detailCareerList.createdAt ?? '',
    );

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
                    child: Image(
                      image: NetworkImage(
                        provider.detailCareerList.image ?? '',
                      ),
                      fit: BoxFit.cover,
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
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      formattedDate,
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
                      provider.detailCareerList.jobPosition ?? 'Tidak ada data',
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
                      provider.detailCareerList.companyName ?? 'Tidak ada data',
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
                      moneyFormatter.formatRupiah(
                        provider.detailCareerList.salary ?? 0000,
                      ),
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
                    crossAxisSpacing: 8,
                    children: [
                      InfoCareerWidget(
                        icon: Icon(
                          Icons.location_on,
                          size: 20,
                          color: MyColor.neutralHigh,
                        ),
                        infoCareer: provider.detailCareerList.location ??
                            'Tidak ada data',
                      ),
                      InfoCareerWidget(
                        icon: Icon(
                          Icons.timer_outlined,
                          size: 20,
                          color: MyColor.neutralHigh,
                        ),
                        infoCareer:
                            'Min Pengalaman ${provider.detailCareerList.minExperience} Tahun',
                      ),
                      InfoCareerWidget(
                        icon: Icon(
                          Icons.work_rounded,
                          size: 20,
                          color: MyColor.neutralHigh,
                        ),
                        infoCareer: provider.detailCareerList.jobType ??
                            'Tidak ada data',
                      ),
                      InfoCareerWidget(
                        icon: Icon(
                          Icons.menu_book_rounded,
                          size: 20,
                          color: MyColor.neutralHigh,
                        ),
                        infoCareer: provider.detailCareerList.lastEducation ??
                            'Tidak ada data',
                      ),
                    ],
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
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: 'Description',
                                style: TextStyle(
                                  color: MyColor.neutralHigh,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Html(
                              data: provider.detailCareerList.description ??
                                  'Tidak ada data',
                              style: {
                                'body': Style(
                                  fontSize: const FontSize(12),
                                  color: MyColor.neutralHigh,
                                ),
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
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: 'How to Apply',
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
                              'Kirim CV, Fotocopy KTP dan Sertifikat Vaksin ke :\n${provider.detailCareerList.companyEmail}\nFile dikirimkan dalam bentuk PDF dan Subjek "Nama_Posisi"',
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
            PrimaryButtonIconText(
              icon: Icon(
                Icons.mail_rounded,
                size: 24,
                color: MyColor.white,
              ),
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
                          onPressed: () async {
                            if (provider.isLoggedIn()) {
                              await provider.getApplyCareer(
                                provider.detailCareerList.companyEmail ?? '',
                              );
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            } else {
                              Navigator.pushReplacementNamed(
                                context,
                                LoginScreen.routeName,
                              );
                            }
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
    );
  }
}
