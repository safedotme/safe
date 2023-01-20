import 'package:flutter/material.dart';
import 'package:safe/models/contact/contact.model.dart';

class ContactTab extends StatelessWidget {
  final Contact contact;
  ContactTab(this.contact);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.red,
    );
  }
}
