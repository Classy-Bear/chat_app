import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

/// Watch all changes and errors of any [Bloc].
///
/// __Note__: This is for debugging purposes only.
class Observer extends BlocObserver {
  final log = Logger();

  @override
  void onChange(Cubit cubit, Change change) {
    log.v(change);
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    log.e('Error in $cubit', error, stackTrace);
    super.onError(cubit, error, stackTrace);
  }
}
