import 'dart:convert';

class FeedbackModel {
  final String feedbackId;
  final String userId;
  final String userEmail;
  final String feedbackType;
  final String description;

  FeedbackModel(
      {required this.feedbackId,
      required this.userId,
      required this.userEmail,
      required this.feedbackType,
      required this.description});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'feedbackId': feedbackId});
    result.addAll({'userId': userId});
    result.addAll({'userEmail': userEmail});
    result.addAll({'feedbackType': feedbackType});
    result.addAll({'description': description});

    return result;
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      feedbackId: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      userEmail: map['userEmail'] ?? '',
      feedbackType: map['feedbackType'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source));
}
