import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/counseling_appointment/counseling_appointment_view_model.dart';
import 'package:capstone_project/view/screen/midtrans/midtrans_webview.dart';
import 'package:capstone_project/view/screen/voucher/voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounselingAppointment extends StatefulWidget {
  static const String routeName = '/counseling_appointment_screen';

  final String? counselorId;
  final String? selectedTimeId;
  final String? selectedMethod;
  final String? dateId;
  final String? timeStart;
  final String? username;
  final String? topic;
  final int? topicId;
  final String? profilePicture;
  final num? price;

  const CounselingAppointment({
    super.key,
    this.counselorId,
    this.selectedTimeId,
    this.selectedMethod,
    this.dateId,
    this.timeStart,
    this.username,
    this.topic,
    this.topicId,
    this.profilePicture,
    this.price,
  });

  @override
  State<CounselingAppointment> createState() => _CounselingAppointmentState();
}

class _CounselingAppointmentState extends State<CounselingAppointment> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<CounselingAppointmentViewModel>(context, listen: false);
      provider.getVoucher(widget.counselorId ?? '');
      provider.selectedVoucher = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(
          MySize.screenWidth(context),
          double.maxFinite,
        ),
        judul: 'Counseling Appointment',
        home: false,
        searchField: false,
        tabBar: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.1,
                ),
              ),
              child: Consumer<CounselingAppointmentViewModel>(
                  builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              widget.profilePicture ?? '',
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.username ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.topic ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  default:
                    return const Center(
                      child: Text('Data Not Avaible'),
                    );
                }
              }),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Counseling Time',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.timeStart ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: MyColor.primaryMain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        widget.selectedMethod! == 'Chat'
                            ? Icons.chat
                            : Icons.videocam,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Counseling Media',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.selectedMethod!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: MyColor.primaryMain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lock_outline,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: const Text(
                        'Semua yang disampaikan dengan konselor / psikolog bersifat rahasia sehingga privasi anda dijamin 100% aman ',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<CounselingAppointmentViewModel>(
                builder: (context, provider, _) {
              switch (provider.myState) {
                case MyState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case MyState.loaded:
                  return InkWell(
                    onTap: () async {
                      if (provider.selectedVoucher != 0) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VoucherScreen(
                              voucherId: provider.selectedVoucher,
                              id: widget.counselorId,
                            ),
                          ),
                        );
                        if (result != null) {
                          provider.decideVoucher(result);
                        }
                      } else {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VoucherScreen(),
                          ),
                        );
                        if (result != null) {
                          // convert result to map
                          provider.decideVoucher(result);
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Row(
                          children: [
                            Transform(
                              transform: Matrix4.rotationZ(0.8),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.book_online,
                                color: MyColor.primaryMain,
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                provider.selectedVoucher == ''
                                    ? 'Apply Voucher'
                                    : 'Voucher Applied',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.rotationZ(0.8),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.outbond,
                                color: MyColor.primaryMain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                default:
                  return const Center(
                    child: Text('Data Not Avaible'),
                  );
              }
            }),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Payment Detail',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.1,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Counseling fee',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            MoneyFormatter().formatRupiah(widget.price ?? 0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Admin fee',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text('free'),
                        ],
                      ),
                      Consumer<CounselingAppointmentViewModel>(
                          builder: (context, provider, _) {
                        provider.countTotal(
                            id: provider.selectedVoucher,
                            price: widget.price!.toInt());
                        switch (provider.myState) {
                          case MyState.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case MyState.loaded:
                            return provider.selectedVoucher == ''
                                ? const SizedBox()
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Discount',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '-${MoneyFormatter().formatRupiah(provider.useVoucher[0].value ?? 0)}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: MyColor.success,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                          default:
                            return const SizedBox();
                        }
                      }),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Consumer<CounselingAppointmentViewModel>(
                              builder: (context, provider, _) {
                            switch (provider.myState) {
                              case MyState.loading:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case MyState.loaded:
                                return Text(
                                  MoneyFormatter().formatRupiah(
                                      provider.selectedVoucher == ''
                                          ? widget.price ?? 0
                                          : provider.total),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              default:
                                return const SizedBox();
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      content: Text(
                        "If the consultant is unable to attend, we offer a refund in the form of a voucher. This voucher can be used towards future transactions. We understand that circumstances may prevent the consultant from fulfilling the appointment, and we want to ensure that you still receive the value of your payment. The voucher will be provided to you, and you can redeem it during your next transaction with us.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Refund Policy',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.neutralMedium,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: MyColor.neutralMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<CounselingAppointmentViewModel>(
                builder: (context, provider, _) {
              switch (provider.myState) {
                case MyState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case MyState.loaded:
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewContainer(
                              counselorId: widget.counselorId,
                              counselorTopicKey: widget.topicId,
                              counsultationDateId: widget.dateId,
                              counsultationMethod: widget.selectedMethod,
                              counsultationTimeId: widget.selectedTimeId,
                              counsultationTimeStart: widget.timeStart,
                              voucherId: provider.selectedVoucher,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.primaryMain,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        'Make Appointment',
                        style: TextStyle(color: MyColor.white),
                      ),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
