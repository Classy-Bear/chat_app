part of './widgets.dart';

/// This decides which widget is seen, depending on the TabCubit state.
class HomeContentWidget extends StatelessWidget {
  /// {@macro chat_app_chat_bloc_chats_chats_bloc}
  final ChatsBloc chatsBloc;

  HomeContentWidget({@required this.chatsBloc}) : assert(chatsBloc != null);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final index = context.watch<TabCubit>().state;
        if (index == 0) return ChatListWidget(chatsBloc);
        if (index == 1) return SettingsListWidget();
        return Container();
      },
    );
  }
}
