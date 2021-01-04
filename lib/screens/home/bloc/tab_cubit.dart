import 'package:bloc/bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

/// The tab where the user is currently in.
class TabCubit extends Cubit<int> {
  TabCubit() : super(0);

  /// Changes the current [state] to the given [index].
  void change(int index) => emit(index);
}
