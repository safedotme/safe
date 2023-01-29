import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_circular_progress_indicator.widget.dart/local_widgets/animated_circular_progress_indicator.widget.dart';
import 'package:safe/widgets/mutable_circular_progress_indicator.widget.dart/mutable_circular_progress_indicator.widget.dart';
import 'package:safe/widgets/mutable_message_icon/mutable_message_icon.widget.dart';
import 'package:safe/widgets/mutable_page/mutable_page.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum MessageType {
  success,
  warning,
  error,
}

class MutableMessagePage extends StatelessWidget {
  final MessageType type;
  final String header;
  final String description;
  final bool loading;

  MutableMessagePage({
    required this.type,
    this.loading = false,
    required this.header,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return MutablePage(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          38,
          80,
          38,
          0,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 375,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: loading,
                  child: Center(
                    child: AnimatedCircularProgressIndicator(),
                  ),
                ),
                Visibility(
                  visible: !loading,
                  child: Center(
                    child: MutableMessageIcon(type),
                  ),
                ),
                SizedBox(height: 25),
                MutableText(
                  header,
                  align: TextAlign.center,
                  size: 20,
                  weight: TypeWeight.heavy,
                ),
                SizedBox(height: 16),
                MutableText(
                  description,
                  align: TextAlign.center,
                  size: 14,
                  color: MutableColor.neutral2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
