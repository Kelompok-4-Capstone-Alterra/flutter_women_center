import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button_icon.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/components/text_box/text_box.dart';
import 'package:capstone_project/utils/my_focus_node.dart';
import 'package:capstone_project/utils/my_reg_exp.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  static const String routeName = '/transaction_screen';

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pertamaController = TextEditingController();
  final TextEditingController _keduaController = TextEditingController();
  final TextEditingController _terakhirController = TextEditingController();
  final FocusNode _pertamaNode = FocusNode();
  final FocusNode _keduaNode = FocusNode();
  final FocusNode _ketigaNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          preferredSize: Size(
            MySize.screenWidth(context),
            double.maxFinite,
          ),
          home: false,
          action: false,
          searchField: true,
          tabBar: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PrimaryButtonIcon(
                teks: 'teks',
                widget: const Icon(Icons.add),
                onPressed: () {},
                customHeight: 36,
                customWidth: 100,
              ),
            )
          ],
          tabs: const [
            Tab(
              text: 'Ongoing',
            ),
            Tab(
              text: 'History',
            ),
          ],
          searchTextBox:
              SearchTextBox(textEditingController: _searchController),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBox(
                        textEditingController: _pertamaController,
                        hintText: 'pertama',
                        autoFocus: true,
                        currentFocus: _pertamaNode,
                        errorMaxLines: 1,
                        hintMaxLines: 1,
                        maxLength: 10,
                        maxLines: 1,
                        last: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(MyRegExp.huruf),
                          FilteringTextInputFormatter.allow(MyRegExp.spasi),
                        ],
                        onFieldSubmitted: (value) {
                          MyFocusNode.change(
                            context: context,
                            currentFocus: _pertamaNode,
                            nextFocus: _keduaNode,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextBox(
                        textEditingController: _keduaController,
                        hintText: 'kedua',
                        currentFocus: _keduaNode,
                        last: false,
                        width: 100,
                        obscureText: true,
                        obscureChar: '',
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(MyRegExp.angka),
                        ],
                        onFieldSubmitted: (value) {
                          MyFocusNode.change(
                              context: context,
                              currentFocus: _keduaNode,
                              nextFocus: _ketigaNode);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextBox(
                        textEditingController: _terakhirController,
                        hintText: 'terakhir',
                        last: true,
                        currentFocus: _ketigaNode,
                        maxLines: 4,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (_terakhirController.text.isEmpty) {
                            return 'Harus diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const PrimaryButton(
                        teks: 'Done',
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
              ),
              const Center(child: Text('teks')),
            ],
          ),
        ),
      ),
    );
  }
}
