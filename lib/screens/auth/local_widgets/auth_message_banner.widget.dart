import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';

class AuthMessageBanner extends StatefulWidget {
  @override
  State<AuthMessageBanner> createState() => _AuthMessageBannerState();
}

class _AuthMessageBannerState extends State<AuthMessageBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableBanner(
        controller: core.state.auth.bannerController,
        type: core.state.auth.bannerState,
        title: core.state.auth.bannerTitle,
        description: core.state.auth.bannerMessage,
        onTap: core.state.auth.onBannerTap,
        onForward: () {
          for (Function f in core.state.auth.onBannerForward) {
            f();
          }
        },
        onReverse: () {
          for (Function f in core.state.auth.onBannerReverse) {
            f();
          }
        },
        duration: core.state.auth.delay,
      ),
    );
  }
}
