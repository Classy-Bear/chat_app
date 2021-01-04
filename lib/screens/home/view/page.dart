import 'package:flutter/gestures.dart';

import '../../../widgets/widgets.dart';
import '../bloc/home_screen/bloc.dart';
import 'tabs/home/home.dart';
import 'widgets/widgets.dart';

/// The main page when the app is open, unless the biometric authentication is
/// enabled.
class HomePage extends StatefulWidget {
  static const route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

/// This can vary depeding on the [HomePageState].
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.watch<HomePageBloc>().state;
        if (state is HomePageFetchedSuccess) {
          return _PageSuccess(chatsBloc: state.chatsBloc);
        }
        if (state is HomePageFetchedFailure) {
          return _PageFailure(errorMessage: state.errorMessage);
        }
        return _PageInProgress();
      },
    );
  }

  @override
  void initState() {
    context.read<HomePageBloc>().add(HomePageFetched());
    super.initState();
  }
}

/// This is shown if the state is [HomePageFetchedInProgress].
class _PageInProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// This is shown if the state is [HomePageFetchedFailure].
class _PageFailure extends StatelessWidget {
  /// The errorMessage that explains what happened while the data were being fetched
  final String errorMessage;

  _PageFailure({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error',
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                errorMessage ?? 'Disculpe los inconvenientes.',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                child: Text('INTENTE NUEVAMENTE'),
                onPressed: () => context.read<HomePageBloc>().add(
                      HomePageFetched(),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// This is show if the data were fetched correctly.
class _PageSuccess extends StatelessWidget {
  /// A bloc used when the contacts are fetched.
  final Bloc chatsBloc;

  _PageSuccess({@required this.chatsBloc}) : assert(chatsBloc != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: TopAppBar(
        title: TabBarWidget(),
      ),
      body: CardContent(
        color: Theme.of(context).colorScheme.secondary,
        child: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ContactsWidget(chatsBloc: chatsBloc),
                ConstrainedBox(
                  child: HomeContentWidget(chatsBloc: chatsBloc),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? viewportConstraints.maxHeight - 170
                        : viewportConstraints.maxHeight,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
