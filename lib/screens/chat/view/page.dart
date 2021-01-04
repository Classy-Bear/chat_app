import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_repository/user_model.dart';

import '../../../widgets/widgets.dart';
import '../bloc/chats/bloc.dart';
import '../bloc/message_sender/bloc.dart';
import 'widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  static const route = '/chat';

  final User receiver;
  final ChatsBloc chatsBloc;

  ChatPage({
    @required this.receiver,
    @required this.chatsBloc,
  })  : assert(receiver != null),
        assert(chatsBloc != null);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: chatsBloc,
        ),
        BlocProvider<MessageTextFieldBloc>(
          create: (conetxt) => MessageTextFieldBloc(),
        ),
      ],
      child: BlocListener<ChatsBloc, ChatsState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            showErrorAlertDialog(
              context,
              message: state.errorMessage,
            );
          }
        },
        child: _PageView(receiver: receiver),
      ),
    );
  }
}

class _PageView extends StatelessWidget {
  final User receiver;

  _PageView({
    @required this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? TopAppBar(
              hasBackButton: true,
              title: Text(
                receiver.name,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : null,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 0,
                        child: CardContent(
                          child: MessageListWidget(
                            receiver: receiver,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      child: MessageSenderWidget(receiver: receiver),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
