part of './home.dart';

class ChatListWidget extends StatelessWidget {
  final ChatsBloc chatsBloc;
  ChatListWidget(this.chatsBloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatsBloc,
      child: Builder(builder: (context) {
        final state = context.watch<ChatsBloc>().state;
        final chats = state.chats.entries
            .where((contacts) => contacts.value.isNotEmpty)
            .map((chats) => chats.key)
            .toList();
        return _ChatList(
          recentChatsContacts: chats,
          itemBuilder: (BuildContext context, int index) {
            return ChatItemWidget(
              user: chats[index],
              onChatPressed: () {
                Navigator.pushNamed(
                  context,
                  ChatPage.route,
                  arguments: ChatPageArguments(
                    receiver: chats[index],
                    chatsBloc: chatsBloc,
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class _ChatList extends StatelessWidget {
  final List recentChatsContacts;
  final Widget Function(BuildContext, int) itemBuilder;

  _ChatList({
    @required this.recentChatsContacts,
    @required this.itemBuilder,
  })  : assert(recentChatsContacts != null),
        assert(itemBuilder != null);

  @override
  Widget build(BuildContext context) {
    return CardContent(
      child: recentChatsContacts.isNotEmpty
          ? ListView.builder(
              itemCount: recentChatsContacts.length,
              shrinkWrap: true,
              itemBuilder: itemBuilder,
            )
          : Center(
              child: Text(
                'Presiona un contacto y comienza a escribir!',
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
