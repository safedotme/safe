import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/home/home.screen.dart';
import 'package:safe/screens/testing/testing.screen.dart';
import 'package:safe/screens/welcome/welcome.screen.dart';
import 'package:safe/widgets/mutable_auth_wrapper/mutable_auth_wrapper.widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  Paint.enableDithering = true;
  await Firebase.initializeApp();

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
        themeMode: ThemeMode.dark,
        routes: {
          WelcomeScreen.id: (_) => WelcomeScreen(),
          HomeScreen.id: (_) => HomeScreen(),
          TestingScreen.id: (_) => TestingScreen(),
        },
        home: MutableAuthWrapper(
          initial: WelcomeScreen(),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
