import 'dart:convert';

class FeedbackModel {
  final String feedbackId;
  final String userId;
  final String userEmail;
  final String feedbackType;
  final String description;
  final String replyDate;
  final bool replyStatus;
  final bool hide;
  final String replyMessage;

  FeedbackModel({
    required this.feedbackId,
    required this.userId,
    required this.userEmail,
    required this.feedbackType,
    required this.description,
    required this.replyDate,
    required this.replyStatus,
    required this.hide,
    required this.replyMessage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'feedbackId': feedbackId});
    result.addAll({'userId': userId});
    result.addAll({'userEmail': userEmail});
    result.addAll({'feedbackType': feedbackType});
    result.addAll({'description': description});
    result.addAll({'replyDate': replyDate});
    result.addAll({'replyStatus': replyStatus});
    result.addAll({'hide': hide});
    result.addAll({'replyMessage': replyMessage});

    return result;
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      feedbackId: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      userEmail: map['userEmail'] ?? '',
      feedbackType: map['feedbackType'] ?? '',
      description: map['description'] ?? '',
      replyDate: map['replyDate'] ?? '',
      replyStatus: map['replyStatus'] ?? false,
      hide: map['hide'] ?? false,
      replyMessage: map['replyMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source));
}
