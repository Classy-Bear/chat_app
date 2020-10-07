import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
	const static route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBarSW(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategorySelector(
              onTap: (i) => context.bloc<TabIndexCubit>().changeIndex(i),
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
                  contacts: favorites,
                  onTap: (user) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        sender: user,
                      ),
                    ),
                  ),
                ),
                HomeContentDW(lastMessages: lastMessages),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
