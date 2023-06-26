import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/formarter/money_formater.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/voucher/voucher_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoucherScreen extends StatefulWidget {
  static const String routeName = '/voucher';

  final String? voucherId;
  final String? id;

  const VoucherScreen({super.key, this.voucherId, this.id});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<VoucherViewModel>(context, listen: false);
      provider.getVoucher(widget.id ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final condition =
        ModalRoute.of(context)!.settings.arguments as bool? ?? false;
    return Scaffold(
      appBar: CustomAppBar(
        home: false,
        judul: 'Voucher',
        preferredSize: Size(
          MySize.screenWidth(context),
          double.maxFinite,
        ),
        searchField: false,
        tabBar: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose one of these promo',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 24),
              Consumer<VoucherViewModel>(builder: (context, provider, _) {
                switch (provider.myState) {
                  case MyState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MyState.loaded:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.voucher.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Refund Voucher',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.success,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Counseling Discount ${MoneyFormatter().formatRupiah(provider.voucher[index].value!)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // create vertical line
                              Container(
                                height: 0.5,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'All payment method accepted',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: MyColor.primaryMain,
                                      ),
                                    ),
                                    widget.voucherId != null &&
                                            widget.voucherId ==
                                                provider.voucher[index].id
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: MyColor.white,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                side: BorderSide(
                                                  color: MyColor.primaryMain,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, {
                                                'id':
                                                    provider.voucher[index].id,
                                                'decide': 'cancel'
                                              });
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: MyColor.primaryMain,
                                              ),
                                            ),
                                          )
                                        : !condition
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      MyColor.primaryMain,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context, {
                                                    'id': provider
                                                        .voucher[index].id,
                                                    'decide': 'choose'
                                                  });
                                                },
                                                child: Text(
                                                  'Choose',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: MyColor.white,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  default:
                    return const Center(
                      child: Text('Data not avaible'),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
