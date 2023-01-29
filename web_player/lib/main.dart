import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/pages/play/play.page.dart';
import 'package:safe/widgets/mutable_message_page/mutable_message_page.widget.dart';
import 'package:safe/widgets/mutable_page/mutable_page.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Paint.enableDithering = true;

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
        debugShowCheckedModeBanner:
            dotenv.env["MEDIA_ENDPOINT"]!.contains(":8080"),
        themeMode: ThemeMode.dark,
        theme: ThemeData.dark(),
        routerConfig: GoRouter(
          errorBuilder: (ctx, state) => MutableMessagePage(
            type: MessageType.warning,
            loading: true,
            header: "Error Loading Incident",
            description:
                "This incident does not exist. This is most likely due to ID next to the URL. Check the ID (live.joinsafe.me/{id}) is valid.",
          ),
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
