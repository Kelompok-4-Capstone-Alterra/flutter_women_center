import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.3,
                ),
              ),
            ),
            child: Row(
              children: const [
                Text(
                  "Sort By",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "cancel",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDB728),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: const [
                Text(
                  "Most Viewed",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Icon(
                  Icons.check,
                  color: Color(0xFFAF1582),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: const [
                Text(
                  "Newest",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: const [
                Text(
                  "Older",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 44,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAF1582),
              ),
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
