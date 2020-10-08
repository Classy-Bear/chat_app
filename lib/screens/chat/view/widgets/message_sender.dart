import 'package:flutter/material.dart';

class MessageSenderWidgetSW extends StatelessWidget {
  const MessageSenderWidgetSW();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 82.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: Theme.of(context).iconTheme.size,
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Escriba su mensaje...",
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: Theme.of(context).iconTheme.size,
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
