import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local_authentication.dart';

class ValidateRaisedButtonDW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          child: Text('VALIDAR'),
          onPressed: state.status.isValidated
              ? () {
                  context.bloc<AuthenticationBloc>().add(
                        AuthenticationSubmitted(),
                      );
                }
              : null,
        );
      },
    );
  }
}
