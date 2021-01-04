part of './home.dart';

class ContactsWidget extends StatelessWidget {
  final ChatsBloc chatsBloc;

  ContactsWidget({@required this.chatsBloc}) : assert(chatsBloc != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatsBloc,
      child: Builder(
        builder: (context) {
          final state = context.watch<ChatsBloc>().state;
          final contacts = state.chats.keys.toList();
          return _Contacts(
            contact: (index) => contacts[index].name,
            onTap: (index) => Navigator.pushNamed(
              context,
              ChatPage.route,
              arguments: ChatPageArguments(
                chatsBloc: chatsBloc,
                receiver: contacts[index],
              ),
            ),
            totalContacts: contacts.length,
          );
        },
      ),
    );
  }
}

class _Contacts extends StatelessWidget {
  final String Function(int) contact;
  final Function(int) onTap;
  final int totalContacts;

  _Contacts({
    @required this.contact,
    @required this.onTap,
    @required this.totalContacts,
  })  : assert(contact != null),
        assert(onTap != null),
        assert(totalContacts != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contactos',
                  style: Theme.of(context).textTheme.headline5,
                ),
              )),
          Container(
            height: 90,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: totalContacts,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    width: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 25,
                          child: Text(
                            contact(index).substring(0, 2),
                            style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ), //Text
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          contact(index),
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
