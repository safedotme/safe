import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/firebase.util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: FirebaseUtil().currentPlatform,
  );

  runApp(Safe());
}

class Safe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Core>(create: (_) => Core()),
      ],
      child: MaterialApp(
        title: "Safe",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text(
              "Hello world",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: "RoundedHeavy",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
