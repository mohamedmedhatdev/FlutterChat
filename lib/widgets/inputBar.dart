import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/chat.cubit.dart';
import 'package:flutter_application_1/bloc/reply_data_cubit.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Common/IconButton.dart';

class InputBar extends StatefulWidget {
  InputBar({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _InputBarState();
  }
}

class _InputBarState extends State<InputBar> {
  TextEditingController controller = TextEditingController();

  BlocBuilder<ReplyDataCubit, ReplyDataState> buildReplyPrompt(
      BuildContext context) {
    final replyData = BlocProvider.of<ReplyDataCubit>(context);
    return BlocBuilder<ReplyDataCubit, ReplyDataState>(
        bloc: replyData,
        builder: (context, state) {
          return Visibility(
            visible: state.replying,
            child: Container(
                constraints: const BoxConstraints(minHeight: 60),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Constants.chatBackgroundColor,
                  border:
                      Border(left: BorderSide(color: Colors.yellow, width: 5)),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                state.msg?.type == EMessageType.sender
                                    ? "You"
                                    : "Him",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow)),
                            Text(state.msg?.content ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white)),
                          ],
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: IconatedButton(
                                  Icons.close,
                                  Constants.accentColor,
                                  20,
                                  onTap: () {
                                    replyData.stopReplying();
                                  },
                                )))
                      ],
                    ))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatsCubit>(context);
    final replyData = BlocProvider.of<ReplyDataCubit>(context);
    return Column(
      children: [
        buildReplyPrompt(context),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: Constants.barsColor,
          alignment: Alignment.center,
          child: Container(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: TextField(
                        controller: controller,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        style: const TextStyle(color: Colors.white),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                            hintText: "Please Enter Your Message...",
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 10),
                            fillColor: Constants.barsColor,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconatedButton(
                            Icons.attach_file_outlined,
                            Constants.accentColor,
                            30,
                            onTap: () async{
                              final file = await FilePicker.platform.pickFiles();
                              chatCubit.addMessage(
                                  0,
                                  CMessage(
                                      "", EMessageType.sender, 0,
                                      baseMsg: replyData.state.msg,imagePath : file?.files[0].path));
                            },
                          ),
                          IconatedButton(
                            Icons.send,
                            Constants.accentColor,
                            30,
                            onTap: () {
                              chatCubit.addMessage(
                                  0,
                                  CMessage(
                                      controller.text, EMessageType.sender, 0,
                                      baseMsg: replyData.state.msg));
                              replyData.stopReplying();
                              controller.clear();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
