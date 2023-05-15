import 'package:capstone_project/components/buttons/circle_button.dart';
import 'package:capstone_project/components/buttons/floating_button.dart';
import 'package:capstone_project/components/buttons/primary_button.dart';
import 'package:capstone_project/components/buttons/primary_button_icon.dart';
import 'package:capstone_project/components/buttons/secondary_button.dart';
import 'package:capstone_project/components/buttons/secondary_button_icon.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:flutter/material.dart';

class PreviewComponentPage extends StatefulWidget {
  const PreviewComponentPage({super.key});

  static const routeName = '/previewComponentPage';

  @override
  State<PreviewComponentPage> createState() => _PreviewComponentPageState();
}

class _PreviewComponentPageState extends State<PreviewComponentPage> {
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
                    color: MyColor.primaryColor,
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
                    color: MyColor.primaryColor,
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
                    color: MyColor.primaryColor,
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
