import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../create_user.dart';

class CreateUserTextFormFieldDW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserBloc, CreateUserState>(
      buildWhen: (previous, current) =>
          previous.createUser != current.createUser,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.bloc<CreateUserBloc>().add(
                  CreateUserChanged(name: value),
                );
          },
          decoration: InputDecoration(
            hintText: 'Ingresa tu nombre...',
            labelText: 'Nombre',
            errorText: state.createUser.invalid ?? false
                ? state.createUser.error == CreateUserFormzValidationError.empty
                    ? 'El campo no puede estar vacío.'
                    : 'El campo no puede contener números.'
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        );
      },
    );
  }
}
