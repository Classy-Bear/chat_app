import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/screens/chat/models/messages.dart';
import 'package:flutter_chat/screens/home/bloc/tab_cubit.dart';

class HomeContentDW extends StatelessWidget {
  final List<Message> lastMessages;
  const HomeContentDW({this.lastMessages});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(builder: (context, state) {
      if (state == 0) {
        return RecentChats(
          chats: lastMessages,
          onChatPressed: (sender) =>
              Navigator.of(context).push(RouteGenerator.getRoute(
            RouteGenerator.chat,
            data: sender,
          )),
        );
      }
      if (state == 1) {
        return SettingsDW();
      }
      // TODO Return a Error Screen.
      return Container();
    });
  }
}
