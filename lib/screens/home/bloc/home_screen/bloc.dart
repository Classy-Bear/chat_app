import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:socket_repository/socket_repository.dart';

import '../../../chat/bloc/chats/bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part './event.dart';
part './state.dart';

/// The bloc that manages the logic of the home page.
///
/// Add one of this events when using this:
/// - [HomePageFetched]
/// Expect one of this states when using this:
/// - [HomePageFetchedSuccess]
/// - [HomePageFetchedInProgress]
/// - [HomePageFetchedFailure]
class HomePageBloc extends Bloc<HomePageFetched, HomePageState> {
  /// {@macro chat_app_packages_socket_repository}
  final SocketRepository repository;

  HomePageBloc({
    @required this.repository,
  })  : assert(repository != null),
        super(null);

  @override
  Stream<HomePageState> mapEventToState(HomePageFetched event) async* {
    yield* _mapHomeScreentFetchedToState(event, state);
  }

  /// The internal logic when [HomePageFetched] is added to [state].
  ///
  /// This makes a HTTP GET request that fetch all users and adds it to the
  /// database, called as contacts.
  Stream<HomePageState> _mapHomeScreentFetchedToState(
    HomePageFetched event,
    HomePageState state,
  ) async* {
    yield HomePageFetchedInProgress();
    try {
      final contacts = await repository.getContacts();
      if (contacts == null) throw Exception();
      final chatsBloc = ChatsBloc(repository: repository);
      chatsBloc.add(ChatsContactsFetched(contacts: contacts));
      repository.messages.listen((message) => chatsBloc.add(
            ChatsMessageCreatedArrived(message: message),
          ));
      repository.users.listen((user) => chatsBloc.add(
            ChatsUserAdded(user: user),
          ));
      repository.deletedUsers.listen((userID) => chatsBloc.add(
            ChatsUserDeleted(userID: userID),
          ));
      yield HomePageFetchedSuccess(chatsBloc: chatsBloc);
    } catch (e) {
      yield HomePageFetchedFailure(errorMessage: 'Error');
    }
  }
}
