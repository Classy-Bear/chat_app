part of './widgets.dart';

class MessageListWidget extends StatefulWidget {
  final User receiver;
  const MessageListWidget({
    @required this.receiver,
  }) : assert(receiver != null);

  @override
  _MessageListWidget createState() => _MessageListWidget();
}

class _MessageListWidget extends State<MessageListWidget> {
  ChatsBloc chatsBloc;
  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    chatsBloc = context.watch<ChatsBloc>();
    return BlocConsumer<ChatsBloc, ChatsState>(
      listener: (context, state) {
        _animatedListKey.currentState.insertItem(0);
      },
      builder: (context, state) {
        final messages = state.chats[widget.receiver].reversed.toList();
        return _MessageList(
          animatedListKey: _animatedListKey,
          length: messages.length,
          message: (index) => messages[index].text,
          sendDate: (index) =>
              messages[index].sendDate.getTimeZoneDifference.toJM,
          isMe: (index) => messages[index].sender.id != widget.receiver.id,
        );
      },
    );
  }

  @override
  void dispose() {
    chatsBloc.add(ChatsReaded(widget.receiver));
    super.dispose();
  }
}

class _MessageList extends StatelessWidget {
  final bool Function(int) isMe;
  final int length;
  final GlobalKey<AnimatedListState> animatedListKey;
  final String Function(int) message;
  final String Function(int) sendDate;

  _MessageList({
    @required this.isMe,
    @required this.animatedListKey,
    @required this.length,
    @required this.message,
    @required this.sendDate,
  })  : assert(isMe != null),
        assert(animatedListKey != null),
        assert(length != null),
        assert(message != null),
        assert(animatedListKey != null),
        assert(sendDate != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: animatedListKey,
      padding: EdgeInsets.only(top: 16.0),
      initialItemCount: length,
      itemBuilder: (context, index, animation) {
        return _MessageListItem(
          message: message(index),
          sendDate: sendDate(index),
          isMe: isMe(index),
          animation: animation,
        );
      },
      shrinkWrap: true,
      reverse: true,
    );
  }
}

class _MessageListItem extends StatelessWidget {
  final Animation<double> animation;
  final bool isMe;
  final String message;
  final String sendDate;

  _MessageListItem({
    @required this.animation,
    @required this.isMe,
    @required this.message,
    @required this.sendDate,
  })  : assert(animation != null),
        assert(message != null),
        assert(sendDate != null),
        assert(isMe != null);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: isMe
          ? Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset(0, 0),
            ).animate(animation)
          : Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset(0, 0),
            ).animate(animation),
      child: Container(
        margin: isMe
            ? EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 80.0,
              )
            : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                right: 80.0,
              ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: isMe
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sendDate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
