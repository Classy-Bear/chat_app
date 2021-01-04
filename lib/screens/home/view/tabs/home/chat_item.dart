part of './home.dart';

class ChatItemWidget extends StatelessWidget {
  final void Function() onChatPressed;
  final User user;

  const ChatItemWidget({
    @required this.onChatPressed,
    @required this.user,
  })  : assert(onChatPressed != null),
        assert(user != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(builder: (context, state) {
      final message = state.chats[user].last;
      return _ChatItem(
        onChatPressed: onChatPressed,
        senderName: user.name,
        isMessageRead: message.read,
        message: message.text,
        messageSendDate: message.sendDate.toJM,
      );
    });
  }
}

class _ChatItem extends StatelessWidget {
  final void Function() onChatPressed;
  final String message;
  final bool isMessageRead;
  final String messageSendDate;
  final String senderName;

  const _ChatItem({
    @required this.senderName,
    @required this.onChatPressed,
    @required this.isMessageRead,
    @required this.message,
    @required this.messageSendDate,
  })  : assert(onChatPressed != null),
        assert(senderName != null),
        assert(isMessageRead != null),
        assert(messageSendDate != null),
        assert(message != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onChatPressed,
        child: Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: !isMessageRead
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          senderName,
                          style: TextStyle(
                            color: isMessageRead
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.60)
                                : Theme.of(context).colorScheme.onPrimary,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          message,
                          style: TextStyle(
                            color: isMessageRead
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.60)
                                : Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    messageSendDate ?? 'Sin Fecha',
                    style: TextStyle(
                      color: isMessageRead
                          ? Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.60)
                          : Theme.of(context).colorScheme.onPrimary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  !isMessageRead
                      ? Container(
                          width: 60.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'NUEVO',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(''), // TODO Can be null?
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
