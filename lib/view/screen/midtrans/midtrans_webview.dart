import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/midtrans/midtrans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../transaction/transaction_screen.dart';

class WebViewContainer extends StatefulWidget {
  final String? counselorId;
  final int? counselorTopicKey;
  final String? counsultationDateId;
  final String? counsultationTimeId;
  final String? counsultationTimeStart;
  final String? counsultationMethod;
  final String? voucherId;

  const WebViewContainer(
      {super.key,
      this.counselorId,
      this.counselorTopicKey,
      this.counsultationDateId,
      this.counsultationTimeId,
      this.counsultationTimeStart,
      this.counsultationMethod,
      this.voucherId});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  num loadingPercentage = 0;
  late WebViewController? controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<MidtransViewModel>(context, listen: false);
      await provider
          .getMidtrans(
              counselorId: widget.counselorId!,
              counselorTopicKey: widget.counselorTopicKey!,
              consultationDateId: widget.counsultationDateId!,
              consultationTimeId: widget.counsultationTimeId!,
              consultationTimeStart: widget.counsultationTimeStart!,
              consultationMethod: widget.counsultationMethod!,
              voucherId: widget.voucherId!)
          .then((value) {
        controller = WebViewController()
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                provider.loadingPercentage = 0;
                if (url.contains('http://example.com')) {
                  Navigator.pop(context);
                  provider.getCounselorDetail(
                      transactionID:
                          provider.transactionMidtrans.data!.transactionId!);
                  if (provider.transactionDetail.data?.status == 'ongoing') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const TransactionScreen();
                          }));
                        });
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 50,
                                  color: MyColor.success,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Payment has been received",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (provider.transactionDetail.data?.status ==
                          'pending' ||
                      provider.transactionDetail.data?.status == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pop(context);
                        });
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.sms_failed,
                                  size: 50,
                                  color: MyColor.danger,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Please complete your payment",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
              onProgress: (progress) {
                provider.loadingPercentage = progress;
              },
              onPageFinished: (url) {
                provider.loadingPercentage = 100;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(provider.transactionMidtrans.data!.paymentLink ?? ''),
          )
          ..setJavaScriptMode(JavaScriptMode.unrestricted);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Consumer<MidtransViewModel>(
            builder: (context, provider, child) {
              if (provider.myState == MyState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.myState == MyState.loaded) {
                return WebViewWidget(controller: controller!);
              } else {
                return const SizedBox();
              }
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
