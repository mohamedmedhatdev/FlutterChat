import 'package:flutter_application_1/models/chat.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsCubit extends Cubit<List<CChat>> {
  ChatsCubit()
      : super([
          CChat(0, [CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.reciever, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("SDSD", EMessageType.sender, 0),
          CMessage("EVV", EMessageType.sender, 0),
          
          
          ], CUser("Ahmed"))
        ]);

  void addMessage(int id, CMessage message) {
    var listCopy = [...state];
    listCopy
        .firstWhere((x) => x.id == id)
        .addMessage(message.content, message.type,message.baseMsg,message.imagePath);
    emit(listCopy);
  }

  void removeMessage(int id, CMessage message) {
    var listCopy = [...state];
    final idx = listCopy.indexWhere((x) => x.id == id);
    listCopy.removeAt(idx);
    emit(listCopy);
  }
}
