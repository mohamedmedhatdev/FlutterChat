import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: const Text(
        "Ahmed",
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      backgroundColor: Constants.barsColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
