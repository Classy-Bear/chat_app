import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
	static const route = '/chat';

  final User receiver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBarSW(
        hasBackButton: true,
        title: Row(
          children: [
            Text(
              receiver.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            TabContentCard(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 16.0),
                itemCount: listLength,
                itemBuilder: (context, index) {
                  // TODO Return Empty screen
                  if (messages.isEmpty) return Container();
                  final message = messages[index];
                  final isMe = message.sender.id == sender.id;
                  return MessageBubble(
                    message: message,
                    isMe: isMe,
                  );
                },
              ),
            ),
            MessageSenderWidgetSW(),
          ],
        ),
      ),
    );
  }
}
