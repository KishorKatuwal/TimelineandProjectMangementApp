import 'dart:convert';

class DiscussionModel {
  final String messageId;
  final String message;
  final String messageTime;
  final String userId;
  final String userName;
  final String userGroup;
  final String userYear;

  DiscussionModel({
    required this.messageId,
    required this.message,
    required this.messageTime,
    required this.userId,
    required this.userName,
    required this.userGroup,
    required this.userYear,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'messageId': messageId});
    result.addAll({'message': message});
    result.addAll({'messageTime': messageTime});
    result.addAll({'userId': userId});
    result.addAll({'userName': userName});
    result.addAll({'userGroup': userGroup});
    result.addAll({'userYear': userYear});

    return result;
  }

  factory DiscussionModel.fromMap(Map<String, dynamic> map) {
    return DiscussionModel(
      messageId: map['_id'] ?? '',
      message: map['message'] ?? '',
      messageTime: map['messageTime'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userGroup: map['userGroup'] ?? '',
      userYear: map['userYear'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscussionModel.fromJson(String source) =>
      DiscussionModel.fromMap(json.decode(source));
}
