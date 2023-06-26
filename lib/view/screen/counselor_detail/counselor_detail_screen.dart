import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/formarter/date_formater.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/counseling_appointment/counseling_appointment_screen.dart';
import 'package:capstone_project/view/screen/counselor_detail/counselor_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CounselorDetailScreen extends StatefulWidget {
  static const routeName = '/counselor_detail';

  final String id;
  final int? topicId;

  const CounselorDetailScreen({super.key, required this.id, this.topicId});

  @override
  State<CounselorDetailScreen> createState() => _CounselorDetailScreenState();
}

class _CounselorDetailScreenState extends State<CounselorDetailScreen> {
  String selectedTime = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final provider =
          Provider.of<CounselorDetailViewModel>(context, listen: false);
      await provider.checkedIsUserLogin();
      if (provider.isLogin == false) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ),
        );
      }
      provider.selectedTime = '';
      await provider.getCounselorDetail(widget.id);
      await provider.getAvaibleTime(widget.id);
      await provider.getCustomerReview(widget.id);
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
                            provider.counselorDetail.profilePicture ?? '',
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/7867/7867562.png',
                                  width: double.infinity,
                                  height: 240,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          provider.counselorDetail.name ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBar(
                          ignoreGestures: true,
                          itemSize: 20,
                          initialRating:
                              provider.counselorDetail.rating?.toDouble() ?? 0,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          allowHalfRating: true,
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: MyColor.warning,
                            ),
                            empty: Icon(
                              Icons.star,
                              color: MyColor.neutralLow,
                            ),
                            half: Icon(
                              Icons.star_half,
                              color: MyColor.warning,
                            ),
                          ),
                          onRatingUpdate: (value) {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          provider.counselorDetail.topic ?? '',
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
                              provider.counselorDetail.price ?? 0),
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColor.primaryMain,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          provider.counselorDetail.description ?? '',
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
                'Choose one of these time: (WIB)',
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
                    if (provider.avaibleTime.times?.length == null) {
                      return const SizedBox(
                        child: Center(
                            child: Text('Counselor Dont Have Avaible Time')),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.avaibleTime.times?.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String time =
                                provider.avaibleTime.times?[index].time ?? '';
                            time = time.substring(0, 5);
                            return Container(
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: provider.selectedTime ==
                                          provider.avaibleTime.times?[index].id
                                      ? MyColor.primaryMain
                                      : provider.avaibleTime.times?[index]
                                                  .isAvailable ==
                                              true
                                          ? MyColor.neutralHigh
                                          : const Color(0xFFE7E4E4),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (provider.avaibleTime.times?[index]
                                          .isAvailable ==
                                      true) {
                                    provider.setSelectedTime(
                                      id: provider.avaibleTime.times?[index].id,
                                      timeID: time,
                                      dateID: provider.avaibleTime.dateId,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: provider.selectedTime ==
                                          provider.avaibleTime.times?[index].id
                                      ? MyColor.primaryMain
                                      : provider.avaibleTime.times?[index]
                                                  .isAvailable ==
                                              true
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
                                            provider
                                                .avaibleTime.times?[index].id)
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
                                      time,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: provider.selectedTime ==
                                                provider.avaibleTime
                                                    .times?[index].id
                                            ? MyColor.white
                                            : provider.avaibleTime.times?[index]
                                                        .isAvailable ==
                                                    true
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
                    }

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
                              if (provider.selectedTime != '') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CounselingAppointment(
                                      counselorId: widget.id,
                                      selectedMethod: 'Chat',
                                      selectedTimeId: provider.selectedTime,
                                      dateId: provider.dateId,
                                      profilePicture: provider
                                          .counselorDetail.profilePicture,
                                      username: provider.counselorDetail.name,
                                      topic: provider.counselorDetail.topic,
                                      price: provider.counselorDetail.price,
                                      timeStart: provider.timeId,
                                      topicId: widget.topicId,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.selectedTime != ''
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
                              if (provider.selectedTime != '') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CounselingAppointment(
                                      counselorId: widget.id,
                                      selectedMethod: 'Video Call',
                                      selectedTimeId: provider.selectedTime,
                                      dateId: provider.dateId,
                                      profilePicture: provider
                                          .counselorDetail.profilePicture,
                                      username: provider.counselorDetail.name,
                                      topic: provider.counselorDetail.topic,
                                      price: provider.counselorDetail.price,
                                      timeStart: provider.timeId,
                                      topicId: widget.topicId,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.selectedTime != ''
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
                    return Column(children: [
                      ListView.builder(
                        itemCount: provider.counselorReview.reviews?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
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
                                    provider.counselorReview.reviews?[index]
                                            .userProfile ??
                                        'https://cdn-icons-png.flaticon.com/512/7867/7867562.png',
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
                                          RatingBar(
                                            ignoreGestures: true,
                                            itemSize: 12,
                                            initialRating: provider
                                                    .counselorReview
                                                    .reviews?[index]
                                                    .rating
                                                    ?.toDouble() ??
                                                0,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            allowHalfRating: true,
                                            ratingWidget: RatingWidget(
                                              full: Icon(
                                                Icons.star,
                                                color: MyColor.warning,
                                              ),
                                              empty: Icon(
                                                Icons.star,
                                                color: MyColor.neutralLow,
                                              ),
                                              half: Icon(
                                                Icons.star_half,
                                                color: MyColor.warning,
                                              ),
                                            ),
                                            onRatingUpdate: (value) {},
                                          ),
                                          Text(
                                            DateFormatter.format(provider
                                                    .counselorReview
                                                    .reviews?[index]
                                                    .createdAt ??
                                                '2023-01-01'),
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
                                        provider.counselorReview.reviews?[index]
                                                .username ??
                                            '',
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
                                          provider.counselorReview
                                                  .reviews?[index].review ??
                                              '',
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
              Consumer<CounselorDetailViewModel>(
                  builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    if (provider.currentPages ==
                        provider.counselorReview.totalPage) {
                      return const SizedBox();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          provider.loadMoreCustomerReview(widget.id);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 40),
                          backgroundColor: MyColor.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          side:
                              BorderSide(color: MyColor.primaryMain, width: 1),
                          elevation: 0,
                        ),
                        child: Text(
                          'Load More',
                          style: TextStyle(color: MyColor.primaryMain),
                        ),
                      );
                    }
                  default:
                    return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
