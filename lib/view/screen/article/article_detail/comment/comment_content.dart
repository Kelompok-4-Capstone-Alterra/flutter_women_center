import 'package:capstone_project/utils/components/loading/loading.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/components/text_box/text_box.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/article/article_detail/comment/comment_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentContent extends StatefulWidget {
  final String articleId;

  const CommentContent({
    Key? key,
    required this.articleId,
  }) : super(key: key);

  @override
  State<CommentContent> createState() => _CommentContentState();
}

class _CommentContentState extends State<CommentContent> {
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CommentProvider>(context, listen: false);
    provider.getComments(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.71,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Consumer<CommentProvider>(
              builder: (context, provider, _) {
                if (provider.myState == MyState.loading) {
                  return const Loading();
                } else if (provider.myState == MyState.loaded &&
                    provider.comments.isEmpty) {
                  return const Center(
                    child: Text('No Comments Yet'),
                  );
                } else if (provider.myState == MyState.loaded &&
                    provider.comments.isNotEmpty) {
                  provider.comments.sort((a, b) =>
                      b.formattedCreatedDate.compareTo(a.formattedCreatedDate));
                  return ListView.builder(
                    itemCount: provider.comments.length,
                    itemBuilder: (context, index) {
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
                                    backgroundImage: NetworkImage(
                                      provider.comments[index].profilePicture ??
                                          '',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.comments[index].username ??
                                              '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          provider.comments[index]
                                              .formattedCreatedDate,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: MyColor.neutralMediumLow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  PopupMenuButton(
                                    offset: const Offset(-40, -30),
                                    icon: Icon(
                                      Icons.more_vert_outlined,
                                      color: provider.getCurrentUserId(
                                              provider.comments[index].userId ??
                                                  '')
                                          ? MyColor.neutralMediumHigh
                                          : Colors.transparent,
                                    ),
                                    enabled: provider.getCurrentUserId(
                                        provider.comments[index].userId ?? ''),
                                    elevation: 0,
                                    position: PopupMenuPosition.under,
                                    color: MyColor.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: .25,
                                        color: MyColor.neutralMediumLow,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    itemBuilder: (_) {
                                      return [
                                        PopupMenuItem(
                                          value: 1,
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
                                      ];
                                    },
                                    onSelected: (value) async {
                                      if (value == 1) {
                                        final commentId =
                                            provider.comments[index].id;
                                        await provider.deleteComments(
                                            widget.articleId, commentId ?? '');
                                        await provider
                                            .getComments(widget.articleId);
                                      }
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  provider.comments[index].comment ?? '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Failed to load data'),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextBox(
              textEditingController: commentController,
              hintText: 'Type what you are thinking here...',
              suffixIcon: IconButton(
                onPressed: () {
                  final provider = Provider.of<CommentProvider>(
                    context,
                    listen: false,
                  );
                  provider.submitComment(
                    commentController.text,
                    widget.articleId,
                  );
                  provider.getComments(widget.articleId);
                  commentController.clear();
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
