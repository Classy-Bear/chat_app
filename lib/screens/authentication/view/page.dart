import 'package:flutter/gestures.dart';

import '../../../widgets/widgets.dart';
import '../models/models.dart';
import '../../../state_managment/blocs/authentication/bloc.dart';
import 'widgets/widgets.dart';

/// This page is responsible of authenticating the current logged user.
class AuthenticationPage extends StatefulWidget {
  static const route = '/auth';

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

/// This request a biometric authentication and shows the page.
class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, TextFieldState>(
        listener: onCodeAuthenticationStateSubmission,
        child: _PageView(),
      ),
    );
  }

  @override
  void initState() {
    authenticateMe(context, context.read<AuthenticationBloc>());
    super.initState();
  }
}

/// The user interface of [AuthenticationPage].
class _PageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
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
                AuthenticationCodeTextFieldWidget(
                  hintText: 'Escriba el código de autenticación',
                ),
                ButtonBar(
                  children: [
                    // TODO Must be a widget
                    OutlineButton(
                        child: Text('HUELLA DIGITAL'),
                        onPressed: () => authenticateMe(
                              context,
                              context.read<AuthenticationBloc>(),
                            )),
                    AuthenticationCodeButtonWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
