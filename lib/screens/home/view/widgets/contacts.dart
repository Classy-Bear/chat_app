import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class Contacts extends StatelessWidget {
  final List<User> contacts;
  final Function(User) onTap;

  Contacts({this.onTap, this.contacts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contactos',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )),
            Container(
              height: 120.0,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => onTap(contacts[index]),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 6.0),
                          Text(
                            contacts[index].name,
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
      ),
    );
  }
}
