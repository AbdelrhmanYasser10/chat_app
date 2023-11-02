import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  late String senderId;
  late String receiverId;
  late String content;
  late Timestamp time;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.time
});

  MessageModel.fromJson(Map<String ,dynamic>json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content = json['content'];
    time = json['time'];
  }

  Map<String,dynamic> toMap(){
    return {
      'senderId': senderId,
      'receiverId':receiverId,
      'content':content,
      'time':time,
    };
  }
}