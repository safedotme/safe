import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_page/mutable_page.widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayPage extends StatefulWidget {
  final String? incidentId;

  PlayPage(this.incidentId);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

// http://localhost:52667/454cdfb0-9fe0-11ed-a8ef-eb8979f70835
class _PlayPageState extends State<PlayPage> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    if (widget.incidentId == null || widget.incidentId!.isEmpty) {
      return;
    }

    initServer();
    subscribe();
  }

  void initServer() => core.services.server.init();

  void subscribe() {
    // Resets values
    core.state.play.setLoading(true);
    core.state.play.setIsCompleted(false);

    // Creates stream query
    final stream = core.services.server.incidents.read(
      widget.incidentId!,
    );

    stream.listen(
      // Loads incident to state
      (incident) {
        core.state.play.setLoading(false);
        core.state.play.setIncident(
          incident,
        );
      },

      // Sends user to completed or error screen
      onError: (e) {
        if (core.state.play.incident != null) {
          core.state.play.setIsCompleted(true);
        }

        core.state.play.setLoading(true);
        core.state.play.setIncident(null);
        context.go("/");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MutablePage(
      body: Observer(
        builder: (_) => Center(
          child: MutableText(
            core.state.play.loading ? "loading..." : widget.incidentId!,
          ),
        ),
      ),
    );
  }
}
