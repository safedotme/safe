import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_insight.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';

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

  void logAnalytics(User user) {
    core.services.analytics.log(
      AnalyticsLog(
        channel: "user-register",
        event: "create-account",
        icon: "⭐️",
        description: "${user.name} has created an account!",
        tags: {
          "userid": user.id,
          "datetime": DateTime.now().toIso8601String(),
        },
      ),
    );

    core.services.analytics.insight(
      AnalyticsInsight(
        title: "Users",
        value: {"\$inc": 1},
        icon: "🦄",
      ),
    );
  }

  void genUser(User? user, Firebase.User firebaseUser) async {
    if (user != null) return;

    DateTime time = DateTime.now();

    var gen = User(
      id: firebaseUser.uid,
      name: core.state.auth.name,
      phone:
          "${core.state.auth.countryDialCode} ${core.state.auth.phoneNumber}",
      picturePath: null,
      credits: 1,
      joined: time,
    );

    logAnalytics(gen);
    core.services.server.user.upsert(gen);
  }

  Future<void> createUser(Firebase.User fbUser) async {
    try {
      final user = await core.services.server.user.readFromIdOnce(
        id: fbUser.uid,
      );

      genUser(user, fbUser);
    } catch (e) {
      genUser(null, fbUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Firebase.User?>(
      stream: core.services.auth.userChanges,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            createUser(snapshot.data!);

            return widget.home;
          }

          return widget.initial;
        }

        return widget.initial;
      },
    );
  }
}
