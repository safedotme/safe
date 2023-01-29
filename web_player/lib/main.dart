import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/pages/messages/incident_not_found.page.dart';
import 'package:safe/pages/play/play.page.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  // Removes # from URL base
  setPathUrlStrategy();
  runApp(Safe());
}

class Safe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Core>(create: (_) => Core()),
      ],
      child: MaterialApp.router(
        title: "Safe Web",
        themeMode: ThemeMode.dark,
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(
          errorBuilder: (ctx, state) => IncidentNotFoundPage(),
          routes: [
            GoRoute(
              path: "/:id",
              builder: (context, state) => PlayPage(state.params["id"]),
            ),
          ],
        ),
      ),
    );
  }
}
