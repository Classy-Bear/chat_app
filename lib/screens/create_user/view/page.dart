import 'package:chat_app/state_managment/blocs/user_text_field/bloc.dart';

import '../../../widgets/widgets.dart';

/// This page is responsible of creating an user.
class CreateUserPage extends StatelessWidget {
  static const route = '/create_user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, TextFieldState>(
        listener: onCreateUserTextFieldSubmission,
        child: _PageView(),
      ),
    );
  }
}

/// The user interface of [CreateUserPage].
class _PageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, viewportConstraints) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Crea una cuenta',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  UserTextFieldWidget(),
                  ButtonBar(
                    children: [
                      UserButtonWidget(
                        isNew: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
