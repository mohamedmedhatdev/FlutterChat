import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/bloc/reply_data_cubit.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Message extends StatefulWidget {
  final CMessage message;
  const Message(this.message, {Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  double baseOffset = 0;
  bool isSender = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      baseOffset = widget.message.type == EMessageType.sender ? 1 : -1;
      isSender = widget.message.type == EMessageType.sender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final replyDataCubit = BlocProvider.of<ReplyDataCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            if (isSender && details.delta.dx < 0 ||
                !isSender && details.delta.dx > 0) {
              baseOffset +=
                  details.delta.dx / (MediaQuery.of(context).size.width / 3);
              baseOffset =
                  clampDouble(baseOffset, isSender ? 0 : -1, isSender ? 1 : 0);
            }
          });
        },
        onHorizontalDragEnd: (_) {
          setState(() {
            replyDataCubit.startReplyingToMessage(widget.message);
            print(replyDataCubit.state.replying);
            baseOffset = widget.message.type == EMessageType.sender ? 1 : -1;
          });
        },
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
          alignment: Alignment(baseOffset, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                color: widget.message.type == EMessageType.sender
                    ? Constants.senderMessageColor
                    : Constants.recepientMessageColor,
                width: MediaQuery.of(context).size.width / 1.5,
                padding: const EdgeInsets.all(10),
                child: _buildMessageContent(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    final currentDate = DateTime.now();
    final [hours, minutes] = [currentDate.hour, currentDate.minute];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.message.imagePath != null,
            child: Image.file(File(widget.message.imagePath ?? ""))),
        Visibility(
            visible: widget.message.baseMsg != null,
            child:
                _buildMessageReplyContainer(context, widget.message.baseMsg)),
        Text(widget.message.content,
            style: const TextStyle(color: Colors.white)),
        Align(
          alignment: Alignment.bottomRight,
          child: Text("$hours : $minutes",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}

Widget _buildMessageReplyContainer(BuildContext context, CMessage? msg) {
  return Container(
    width: MediaQuery.of(context).size.width - 10,
    constraints: const BoxConstraints(minHeight: 50),
    decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.yellow, width: 5)),
        color: Constants.chatBackgroundColor),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(msg?.type == EMessageType.sender ? "You" : "Him",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow)),
          Text(msg?.content ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.w300, color: Colors.white)),
        ],
      ),
    ),
  );
}
