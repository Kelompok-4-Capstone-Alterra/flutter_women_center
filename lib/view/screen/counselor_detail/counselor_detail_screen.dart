import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/formarter/date_formater.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/counseling_appointment/counseling_appointment_screen.dart';
import 'package:capstone_project/view/screen/counselor_detail/counselor_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_rating/star_rating.dart';

class CounselorDetailScreen extends StatefulWidget {
  static const routeName = '/counselor_detail';

  const CounselorDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<CounselorDetailScreen> createState() => _CounselorDetailScreenState();
}

class _CounselorDetailScreenState extends State<CounselorDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<CounselorDetailViewModel>(context, listen: false);
      provider.getCounselorDetail(widget.id);
      provider.getAvaibleTime();
      provider.getCustomerReview(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final MoneyFormatter moneyFormatter = MoneyFormatter();
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(
          MySize.screenWidth(context),
          double.maxFinite,
        ),
        judul: 'Counselor',
        home: false,
        searchField: false,
        tabBar: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<CounselorDetailViewModel>(
                  builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: Image.network(
                            provider.counselorDetail[0]['image'],
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          provider.counselorDetail[0]['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StarRating(
                          mainAxisAlignment: MainAxisAlignment.start,
                          length: 5,
                          rating:
                              provider.counselorDetail[0]['rating'].toDouble(),
                          between: 2,
                          starSize: 20,
                          color: MyColor.warning,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          provider.counselorDetail[0]['specialist'],
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColor.neutralMediumLow,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          moneyFormatter.formatRupiah(
                              provider.counselorDetail[0]['price']),
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColor.primaryMain,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          provider.counselorDetail[0]['description'],
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  default:
                    return const SizedBox(
                      child: Text('No Data Avaible'),
                    );
                }
              }),
              const Text(
                'Choose one of these time:',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 16,
              ),
              // listview builder with side scroll
              Consumer<CounselorDetailViewModel>(
                  builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.avaibleTime.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: provider.selectedTime ==
                                        provider.avaibleTime[index]['id']
                                    ? MyColor.primaryMain
                                    : provider.avaibleTime[index]['status'] ==
                                            'active'
                                        ? MyColor.neutralHigh
                                        : const Color(0xFFE7E4E4),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (provider.avaibleTime[index]['status'] ==
                                    'active') {
                                  provider.setSelectedTime(
                                      provider.avaibleTime[index]['id']);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: provider.selectedTime ==
                                        provider.avaibleTime[index]['id']
                                    ? MyColor.primaryMain
                                    : provider.avaibleTime[index]['status'] ==
                                            'active'
                                        ? MyColor.white
                                        : const Color(0xFFE7E4E4),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (provider.selectedTime ==
                                          provider.avaibleTime[index]['id'])
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.check,
                                            size: 16,
                                            color: MyColor.white,
                                          ),
                                        )
                                      : const SizedBox(),
                                  Text(
                                    provider.avaibleTime[index]['time'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: provider.selectedTime ==
                                              provider.avaibleTime[index]['id']
                                          ? MyColor.white
                                          : provider.avaibleTime[index]
                                                      ['status'] ==
                                                  'active'
                                              ? MyColor.neutralHigh
                                              : MyColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  default:
                    return const SizedBox(
                      child: Text('No Data Avaible'),
                    );
                }
              }),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Choose one of these methods:',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<CounselorDetailViewModel>(
                  builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (provider.selectedTime != 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CounselingAppointment(
                                      counselorId: provider.counselorDetail[0]
                                          ['id'],
                                      selectedMethod: 'Chat',
                                      selectedTimeId: provider.selectedTime,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.selectedTime != 0
                                  ? MyColor.primaryMain
                                  : const Color(0xFFE7E4E4),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Chat',
                              style: TextStyle(color: MyColor.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (provider.selectedTime != 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CounselingAppointment(
                                      counselorId: provider.counselorDetail[0]
                                          ['id'],
                                      selectedMethod: 'Video Call',
                                      selectedTimeId: provider.selectedTime,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.selectedTime != 0
                                  ? MyColor.primaryMain
                                  : const Color(0xFFE7E4E4),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Video Call',
                              style: TextStyle(color: MyColor.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  default:
                    return const SizedBox(
                      height: 50,
                      child: Text('No Data Avaible'),
                    );
                }
              }),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Customer's Review:",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<CounselorDetailViewModel>(
                  builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    // return SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.1,
                    //   child: ListView.builder(
                    //     itemCount: provider.customerReview.length,
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       // return Placeholder();
                    //       return Container(
                    //         margin: const EdgeInsets.only(right: 16),
                    //         padding: const EdgeInsets.only(
                    //             left: 8, right: 8, top: 8, bottom: 8),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: MyColor.neutralLow,
                    //             width: 1,
                    //           ),
                    //           borderRadius: BorderRadius.circular(3),
                    //         ),
                    //         child: Row(
                    //           children: [
                    //             CircleAvatar(
                    //               radius: 20,
                    //               backgroundImage: NetworkImage(
                    //                 provider.customerReview[index]['image'],
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 20,
                    //             ),
                    //             SizedBox(
                    //               width: 200,
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       StarRating(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         length: 5,
                    //                         rating: provider
                    //                             .customerReview[index]['rating']
                    //                             .toDouble(),
                    //                         between: 2,
                    //                         starSize: 12,
                    //                         color: MyColor.warning,
                    //                       ),
                    //                       Text(
                    //                         DateFormatter.format(
                    //                             provider.customerReview[index]
                    //                                 ['createdAt']),
                    //                         style: TextStyle(
                    //                             fontSize: 8,
                    //                             color: MyColor.neutralHigh),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   const SizedBox(
                    //                     height: 5,
                    //                   ),
                    //                   Text(
                    //                     provider.customerReview[index]['name'],
                    //                     style: TextStyle(
                    //                       fontSize: 12,
                    //                       color: MyColor.neutralHigh,
                    //                       fontWeight: FontWeight.bold,
                    //                     ),
                    //                   ),
                    //                   const SizedBox(
                    //                     height: 5,
                    //                   ),
                    //                   SizedBox(
                    //                     height:
                    //                         MediaQuery.of(context).size.height *
                    //                             0.035,
                    //                     child: Text(
                    //                       provider.customerReview[index]
                    //                           ['review'],
                    //                       style: TextStyle(
                    //                         fontSize: 12,
                    //                         color: MyColor.neutralHigh,
                    //                       ),
                    //                       overflow: TextOverflow.ellipsis,
                    //                       maxLines: 2,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );

                    //     },
                    //   ),
                    // );
                    return Column(children: [
                      ListView.builder(
                        itemCount: provider.customerReview.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // return Placeholder();
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColor.neutralLow,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    provider.customerReview[index]['image'],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.72,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          StarRating(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            length: 5,
                                            rating: provider
                                                .customerReview[index]['rating']
                                                .toDouble(),
                                            between: 2,
                                            starSize: 12,
                                            color: MyColor.warning,
                                          ),
                                          Text(
                                            DateFormatter.format(
                                                provider.customerReview[index]
                                                    ['createdAt']),
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: MyColor.neutralHigh),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.customerReview[index]['name'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: MyColor.neutralHigh,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.035,
                                        child: Text(
                                          provider.customerReview[index]
                                              ['review'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: MyColor.neutralHigh,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ]);
                  default:
                    return const SizedBox(
                      height: 50,
                      child: Text('No Data Avaible'),
                    );
                }
              }),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CounselorDetailViewModel>(context, listen: false)
                      .loadMoreCustomerReview(widget.id);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  backgroundColor: MyColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  side: BorderSide(color: MyColor.primaryMain, width: 1),
                  elevation: 0,
                ),
                child: Text(
                  'Load More',
                  style: TextStyle(color: MyColor.primaryMain),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
