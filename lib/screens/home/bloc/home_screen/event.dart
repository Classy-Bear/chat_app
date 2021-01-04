part of './bloc.dart';

/// This should be added once a page in inicialized like this:
///
/// Fetch all the users from the API once called.
///
/// ```dart
/// @override
/// void initState() {
///   context.read<HomeScreenBloc>().add(HomeScreenFetched());
///   super.initState();
/// }
/// ```
class HomePageFetched {
  const HomePageFetched();
}
