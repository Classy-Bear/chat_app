import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/chat/chat.dart';
import 'package:flutter_chat/screens/home/view/widgets/home_content.dart';
import 'package:flutter_chat/widgets/widgets.dart';
import '../home.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
	static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBarSW(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategorySelector(
              onTap: (i) => context.bloc<TabCubit>().change(i),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          TabContentCard(
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Contacts(
                  contacts: ,
                  onTap: (user) => Navigator.pushNamed(
                    context,
										ChatPage.route,
										arguments: user,
                  ),
                ),
                HomeContentDW(lastMessages: ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
