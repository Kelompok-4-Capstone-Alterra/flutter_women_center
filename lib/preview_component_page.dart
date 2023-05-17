import 'package:capstone_project/utils/components/buttons/circle_button.dart';
import 'package:capstone_project/utils/components/buttons/floating_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button_icon.dart';
import 'package:capstone_project/utils/components/buttons/secondary_button.dart';
import 'package:capstone_project/utils/components/buttons/secondary_button_icon.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/components/text_box/text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_focus_node.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class PreviewComponentPage extends StatefulWidget {
  const PreviewComponentPage({super.key});

  static const routeName = '/previewComponentPage';

  @override
  State<PreviewComponentPage> createState() => _PreviewComponentPageState();
}

class _PreviewComponentPageState extends State<PreviewComponentPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final FocusNode _namaNode = FocusNode();
  final FocusNode _alamatNode = FocusNode();
  final FocusNode _kotaNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        widget: const Icon(Icons.sort),
        teks: 'Sort By',
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextBox(
                  textEditingController: _namaController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextBox(
                  textEditingController: _namaController,
                  hintText: 'Ex: Budi',
                  currentFocus: _namaNode,
                  onFieldSubmitted: (value) {
                    MyFocusNode.change(
                      context: context,
                      currentFocus: _namaNode,
                      nextFocus: _alamatNode,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextBox(
                  textEditingController: _alamatController,
                  hintText: 'Ex: Alamat',
                  currentFocus: _alamatNode,
                  width: MySize.halfWidth(context),
                  onFieldSubmitted: (value) {
                    MyFocusNode.change(
                      context: context,
                      currentFocus: _alamatNode,
                      nextFocus: _kotaNode,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextBox(
                  textEditingController: _kotaController,
                  hintText: 'Ex: Kota',
                  currentFocus: _kotaNode,
                  width: 134,
                  last: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  teks: 'Full Width',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  customWidth: MySize.halfWidth(context),
                  teks: 'Half Width',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  customWidth: 134,
                  teks: 'custom',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButtonIcon(
                  teks: 'Full Width',
                  widget: const Icon(Icons.email),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButtonIcon(
                  customWidth: MySize.halfWidth(context),
                  teks: 'Half Width',
                  widget: const Icon(Icons.add),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButtonIcon(
                  customWidth: 134,
                  teks: 'Custom',
                  widget: const Icon(Icons.add),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  teks: 'Full Width',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  customWidth: MySize.halfWidth(context),
                  teks: 'Half Width',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  customWidth: 134,
                  teks: 'Custom',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButtonIcon(
                  teks: 'Full Width',
                  widget: Icon(
                    Icons.email,
                    color: MyColor.primary,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButtonIcon(
                  customWidth: MySize.halfWidth(context),
                  teks: 'Half Width',
                  widget: Icon(
                    Icons.email,
                    color: MyColor.primary,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButtonIcon(
                  customWidth: 134,
                  teks: 'Custom',
                  widget: Icon(
                    Icons.email,
                    color: MyColor.primary,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                CircleButton(
                  widget: const Icon(Icons.percent),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
