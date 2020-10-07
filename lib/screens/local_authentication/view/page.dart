import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../models/biometrics_auth.dart';

class AuthenticationPage extends StatefulWidget {
  static const route = '/auth';
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) SnackBarDW.error(context);
        },
        child: Center(
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verificarse',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 16,
                ),
                CodeTextFormFieldDW(),
                ButtonBar(
                  children: [
                    OutlineButton(
                      child: Text('HUELLA DIGITAL'),
                      onPressed: () => callAuth(context),
                    ),
                    ValidateRaisedButtonDW(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void callAuth(BuildContext context) {
    BiometricsAuthentication().authenticate().then((isBiometricsCorrect) {
      if (isBiometricsCorrect) {
        context.bloc<AuthenticationBloc>().add(
              AuthenticationSubmitted(
                isBiometricsCorrect: isBiometricsCorrect,
              ),
            );
      }
    }).catchError((e) => showDialog(
          context: context,
          builder: (_) => ErrorAlertDialogSW(
            title: 'Error',
            message: '${e.message}',
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    // TODO [?] Before or after init state.
    callAuth(context);
  }
}
