import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/pages/play/local_widgets/player_data_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class PlayerDataColumn extends StatefulWidget {
  @override
  State<PlayerDataColumn> createState() => _PlayerDataColumnState();
}

class _PlayerDataColumnState extends State<PlayerDataColumn> {
  late Core core;
  String? battery;
  String? speed;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  void listenBattery(Incident i) {
    if (i.battery == null || i.battery!.isEmpty) return;

    i.battery!.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );

    final latest = core.utils.player.parseBattery(
      i.battery!.last,
    );

    if (latest == null) return;

    if (latest == battery) return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        battery = latest;
      });
    });
  }

  void listenSpeed(Incident i) {
    if (i.location == null || i.location!.isEmpty) return;

    i.location!.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );

    final latest = core.utils.player.parseSpeed(
      i.location!.last,
    );

    if (latest == null) return;

    if (latest == speed) return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        speed = latest;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        listenBattery(core.state.play.incident!);
        listenSpeed(core.state.play.incident!);

        return Transform.scale(
          alignment: Alignment.topRight,
          scale: 1.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              battery == null
                  ? SizedBox()
                  : PlayerDataBox(
                      icon: MutableIcon(
                        MutableIcons.battery,
                        color: kColorMap[MutableColor.neutral3]!,
                        size: Size(17, 8),
                      ),
                      header: "Battery",
                      value: battery!,
                    ),
              SizedBox(height: 6),
              speed == null
                  ? SizedBox()
                  : PlayerDataBox(
                      icon: MutableIcon(
                        MutableIcons.location,
                        color: kColorMap[MutableColor.neutral3]!,
                        size: Size(10, 10),
                      ),
                      header: "SPEED",
                      value: speed!,
                    ),
            ],
          ),
        );
      },
    );
  }
}
