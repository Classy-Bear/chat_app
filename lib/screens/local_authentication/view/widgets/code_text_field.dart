import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local_authentication.dart';

class CodeTextFormFieldDW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context.bloc<AuthenticationBloc>().add(
                  AuthenticationCodeChanged(code: value),
                );
          },
          decoration: InputDecoration(
            hintText: 'Ingresa el código de verificación',
            labelText: 'Código de verificación',
            errorText: state.code.invalid ?? false
                ? 'El campo no debe estar vacío'
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          onSaved: (value) => context.bloc<AuthenticationBloc>().add(
                AuthenticationSubmitted(code: value),
              ),
          obscureText: true,
        );
      },
    );
  }
}
