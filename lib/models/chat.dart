import 'package:flutter_application_1/models/message.dart';
import 'package:flutter_application_1/models/user.dart';

class CChat {
  int id = 0;
  List<CMessage> messages = [];
  CUser? recepient;

  void addMessage(String message, EMessageType type,CMessage? baseMsg,String? imagePath) {
    messages.add(CMessage(message, type, messages.length,baseMsg: baseMsg,imagePath: imagePath));
  }

  void removeMessage(int id) {
    messages.remove(messages.firstWhere((x) => x.id == id));
  }

  CChat(this.id, this.messages, this.recepient);
}
