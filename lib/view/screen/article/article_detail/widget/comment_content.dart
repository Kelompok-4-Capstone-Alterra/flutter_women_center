import 'package:capstone_project/model/comment_model.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_pop_up_menu_button.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/components/text_box/text_box.dart';
import 'package:flutter/material.dart';

class CommentContent extends StatelessWidget {
  const CommentContent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                final Comment comments = commentList[index];
                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              child: Image.asset(
                                comments.image,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comments.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    comments.day,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: MyColor.neutralMediumLow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            CustomPopupMenuButton(
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 1,
                                        // row has two child icon and text.
                                        child: Row(
                                          children: [
                                            Text(
                                              "Delete Comment",
                                              style: TextStyle(
                                                color: MyColor.danger,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                onSelected: (value) {
                                  if (value == 1) {}
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(comments.comment),
                        )
                      ],
                    ),
                  ),
                );
              }),
              itemCount: commentList.length,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextBox(
              textEditingController: commentController,
              hintText: 'Type what are you thinking here ...',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
