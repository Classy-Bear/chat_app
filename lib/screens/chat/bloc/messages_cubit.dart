import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<Map<String, List<Message>>> {
  MessagesCubit() : super(<String, List<Message>>{}) {
    server.messages.listen((listOfMsg) {
      for (final msg in listOfMsg) {
        emit({msg.keys.elementAt(0): msg.values.elementAt(0)});
      }
    });
  }

  static const id = /* Get UUID from current user */ '212121';

  final server = SocketServer(id);

  void addMessage(String message) {
    server.createMessage({id: message});
  }
}
