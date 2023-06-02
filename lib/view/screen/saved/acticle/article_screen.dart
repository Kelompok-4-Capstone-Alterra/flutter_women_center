import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  static const String routeName = '/article_screen';

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Articles',
        home: false,
        searchField: false,
        tabBar: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.comment),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: MySize.bodyHalfWidth(context) - 8,
                      child: Text(
                        'Membangun Motivasi untuk Atasi Depresi',
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: MyColor.neutralHigh,
                        ),
                      ),
                    ),
                    Text(
                      '24 Desember 2023',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: MyColor.neutralMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori Artikel (Mental Health)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MyColor.neutralMedium,
                      ),
                    ),
                    Text(
                      'AGUSTIN DWIPUTRI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MyColor.neutralMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Image.network(
                'https://images.unsplash.com/photo-1477332552946-cfb384aeaf1c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: Text(
                  'Depresi merupakan gangguan mental yang umum. Gejalanya dapat berkisar dari ringan hingga berat, utamanya adalah tampilnya emosi kesedihan terus-menerus dalam waktu minimal dua minggu.\n\nGangguan depresi bisa menjadi kronis, berulang, dan dapat juga terjadi dalam satu kali episode yang disebabkan oleh peristiwa kehidupan yang berat, seperti kematian dalam keluarga, berakhirnya pernikahan, dan kesulitan keuangan. Beberapa gejala depresi meliputi berkurangnya minat pada aktivitas yang biasanya menyenangkan, insomnia atau peningkatan kebutuhan tidur, kurang nafsu makan atau kebutuhan makan meningkat, lekas marah atau kelelahan, kesulitan berkonsentrasi dan menyelesaikan tugas-tugas harian, serta citra diri yang buruk (Timothy J Legg, 2016).\n\nRobert L Leahy (2021), profesor psikologi klinis di Weill-Cornell Medical School, mengatakan depresi adalah sistem keyakinan, perilaku, dan cara berelasi dengan orang yang membuat seseorang terkunci dalam perangkap. Salah satu elemen kunci dari depresi adalah keyakinan bahwa segala sesuatunya tidak ada harapan.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: MyColor.neutralHigh,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
