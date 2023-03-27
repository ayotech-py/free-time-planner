// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String? commentId;
  final String? userId;
  final String? comment;
  final String? userName;
  final String? avatar;
  final String? time;
  final Timestamp? timeStamp;
  final String? date;
  CommentModel(
      {this.commentId,
      this.userId,
      this.time,
      this.comment,
      this.userName,
      this.avatar,
      this.date,
      this.timeStamp});

  factory CommentModel.fromFirestore(DocumentSnapshot map) {
    return CommentModel(
      commentId: map['commentId'],
      userId: map['userId'],
      comment: map['comment'],
      avatar: map['avatar'],
      time: map['time'],
      userName: map['userName'],
      timeStamp: map['timeStamp'],
      date: map['date'],
    );
  }
}
