part of './bloc.dart';

/// Represents the state of a page that fetchs the users.
///
/// Do not call this directly to add a new state, instead call events that
/// `extends` this class.
///
/// See:
/// - [HomePageFetchedInProgress]
/// - [HomePageFetchedSuccess]
/// - [HomePageFetchedFailure]
abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

/// The [HomePageFetchedInProgress] fails to fetch the users.
///
/// Use [errorMessage] that explains what happened while fetching the users. You
/// may use it in the UI like this:
///
/// ```dart
/// ...
/// Text(errorMessage),
/// ...
/// ```
class HomePageFetchedFailure extends HomePageState {
  /// Explains the error that happened while fetching the user.
  final String errorMessage;

  const HomePageFetchedFailure({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}

/// The user are being fetched.
class HomePageFetchedInProgress extends HomePageState {}

/// The [HomePageFetchedInProgress] succeeds to fetch the users.
class HomePageFetchedSuccess extends HomePageState {
  /// The bloc .
  final ChatsBloc chatsBloc;

  const HomePageFetchedSuccess({@required this.chatsBloc})
      : assert(chatsBloc != null);

  @override
  List<Object> get props => [chatsBloc];
}
