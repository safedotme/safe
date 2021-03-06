import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/user/user.model.dart';

class MutableAuthWrapper extends StatefulWidget {
  final Widget initial;
  final Widget home;

  MutableAuthWrapper({
    required this.initial,
    required this.home,
  });

  @override
  State<MutableAuthWrapper> createState() => _MutableAuthWrapperState();
}

class _MutableAuthWrapperState extends State<MutableAuthWrapper> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  void genUser(User? user, Firebase.User firebaseUser) async {
    if (user != null) return;
    DateTime time = DateTime.now();

    var gen = User(
      id: firebaseUser.uid,
      name: core.state.auth.name,
      phone: core.state.auth.phoneNumber,
      picturePath: null,
      incidents: [],
      contacts: [],
      joined: time,
    );

    core.services.server.user.upsert(gen);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Firebase.User?>(
      stream: core.services.auth.userChanges,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            // Generate data if it doesn't already
            core.services.server.user
                .readFromIdOnce(id: snapshot.data!.uid)
                .then((value) => genUser(value, snapshot.data!));

            return widget.home;
          }

          return widget.initial;
        }

        return widget.initial;
      },
    );
  }
}
