import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:user_repository/user_repository.dart';

class UserCubit extends HydratedCubit<User> {
  UserCubit() : super(null);

  void create(User user) => emit(user);

  void delete() => emit(null);

  @override
  User fromJson(Map<String, dynamic> json) => User(
        uuid: json['uuid'],
        name: json['name'],
      );

  @override
  Map<String, String> toJson(User state) => {
        'uuid': state.uuid,
        'name': state.name,
      };
}
