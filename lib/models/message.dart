import 'package:flutter_application_1/models/user.dart';

enum EMessageType { sender, reciever }

class CMessage {
  final EMessageType type;
  final String content;
  final num id;
  final CMessage? baseMsg;
  final String? imagePath;
  const CMessage(this.content, this.type, this.id,{this.baseMsg,this.imagePath});
}
