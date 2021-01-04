part of './widgets.dart';

class MessageSenderWidget extends StatelessWidget {
  final User receiver;

  MessageSenderWidget({this.receiver});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MessageTextFieldBloc>().state;
    return MessageSender(
      onSendMessage: state.status.isValidated
          ? () {
              final settings = context.read<SettingsBloc>().state.settings;
              final date = DateTime.now();
              final message = Message(
                // TODO Generate ID
                id: 'generate-id-here',
                text: state.validator.value,
                dateOffset: date.timeZoneOffset,
                sender: User(
                  id: settings['${SettingsKeys.userID}'],
                  name: settings['${SettingsKeys.userName}'],
                ),
                read: false,
                receiver: receiver,
                sendDate: date,
              );
              context.read<ChatsBloc>().add(ChatsMessageCreated(
                    message: message,
                  ));
              context
                  .read<MessageTextFieldBloc>()
                  .add(MessageTextFieldSubmitted());
            }
          : null,
      onMessageChanged: (value) => context
          .read<MessageTextFieldBloc>()
          .add(MessageTextFieldChanged(message: value)),
    );
  }
}

class MessageSender extends StatefulWidget {
  final Function() onSendMessage;
  final Function(String) onMessageChanged;

  const MessageSender({
    @required this.onSendMessage,
    @required this.onMessageChanged,
  });

  @override
  _MessageSenderState createState() => _MessageSenderState();
}

class _MessageSenderState extends State<MessageSender> {
  final messageTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CardContent(
      cardBorderRadius: BorderRadius.all(
        Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Escriba su mensaje...',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: widget.onMessageChanged,
                controller: messageTextFieldController,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: Theme.of(context).iconTheme.size,
              color: messageTextFieldController.value.text.isNotEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onPrimary.withOpacity(0.60),
              onPressed: () {
                widget.onSendMessage();
                messageTextFieldController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageTextFieldController.dispose();
    super.dispose();
  }
}
