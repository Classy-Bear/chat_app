import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../create_user.dart';

class CreateUserRaisedButtonDW extends StatelessWidget {
  final Function() onPressed;

  const CreateUserRaisedButtonDW({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserBloc, CreateUserState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          child: Text('CREAR'),
          onPressed: state.status.isValidated ? onPressed : null,
        );
      },
    );
  }
}
