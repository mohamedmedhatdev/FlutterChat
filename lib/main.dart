import 'package:flutter/material.dart';
import 'package:flutter_application_1/appBar.dart';
import 'package:flutter_application_1/bloc/chat.cubit.dart';
import 'package:flutter_application_1/bloc/reply_data_cubit.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/chat.dart';
import 'package:flutter_application_1/widgets/inputBar.dart';
import 'package:flutter_application_1/widgets/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatsCubit>(
          create: (_) => ChatsCubit(),
        ),
        BlocProvider<ReplyDataCubit>(create: (_) => ReplyDataCubit())
      ],
      child: MaterialApp(
        title: 'Ahmed',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatsCubit>(context);
    final chat = chatCubit.state[0];
    return Scaffold(
        appBar: const ChatAppBar(),
        body: Column(
          children: [
            Expanded(
                child: Container(
              color: Constants.chatBackgroundColor,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocConsumer<ChatsCubit, List<CChat>>(
                        bloc: chatCubit,
                        builder: (context, state) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chat.messages.length,
                            itemBuilder: (context, index) {
                              return Message(chat.messages[index]);
                            },
                          );
                        },
                        listener: (context, state) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
            InputBar()
          ],
        ));
  }
}
