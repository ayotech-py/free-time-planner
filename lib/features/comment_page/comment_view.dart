import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:free_time_planner/features/comment_page/comment_controller.dart';
import 'package:free_time_planner/models/comment_model/comment_model.dart';
import 'package:free_time_planner/routes/exports.dart';

class CommentPageView extends StatelessWidget {
  final String commentId;
  const CommentPageView({super.key, required this.commentId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      init: CommentController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const AppText('Comment'),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: controller.getStreamFireStore(commentId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      controller.comments = snapshot.data!.docs;
                      print(snapshot.data!.docs);
                      if (controller.comments.isNotEmpty) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            CommentModel commentModel =
                                CommentModel.fromFirestore(
                                    snapshot.data!.docs[index]);

                            return FocusedMenuHolder(
                              blurBackgroundColor: Colors.white54,
                              menuOffset: 15,
                              menuItems: [
                                FocusedMenuItem(
                                  backgroundColor: Colors.red,
                                  title: const Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onPressed: () async {
                                    await controller
                                        .deleteComment(commentModel.commentId!);
                                    // _getReplies(commentId);
                                    //Navigator.pop(context);
                                  },
                                  trailingIcon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                              openWithTap: true,
                              onPressed: () {},
                              child: Container(
                                  margin: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppText(
                                        commentModel.userName!,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      AppText(
                                        commentModel.comment!,
                                        size: 18,
                                      ),
                                    ],
                                  )),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          reverse: false,
                          controller: controller.listScrollController,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'No Comment sent yet, Be the first',
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              _bottomWidget(context,
                  controller: controller.textEditingController,
                  onTap: () async {
                final post = await controller.postComment(
                  commentId,
                );
                if (post == true) {
                  controller.textEditingController.clear();
                }
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomWidget(BuildContext context,
      {required TextEditingController controller, required Function() onTap}) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), //New
              blurRadius: 15,
              blurStyle: BlurStyle.normal,
              spreadRadius: 5,
              // offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      //color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 0),
                      contentPadding: EdgeInsets.only(left: 15, right: 10),
                      border: InputBorder.none,
                      hintText: 'Write a comment',
                    ),
                    controller: controller,
                  ),
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 10),
              icon: Icon(
                Icons.send,
                size: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: onTap,
            )
          ],
        ),
      ),
    );
  }
}
