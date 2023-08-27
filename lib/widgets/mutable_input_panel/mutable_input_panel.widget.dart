import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_icon_sphere/mutable_icon_sphere.widget.dart';
import 'package:safe/widgets/mutable_large_button/mutable_large_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableInputPanel extends StatefulWidget {
  final Widget body;
  final bool resizeToAvoidBottomInsets;
  final void Function()? onTap;
  final Size? iconSize;
  final bool isActive;
  final Widget? aboveButtonWidget;
  final String buttonText;
  final String title;
  final bool shimmer;
  final bool accomodateBottomInsets;
  final MutableIcons icon;

  final String description;

  MutableInputPanel({
    this.accomodateBottomInsets = false,
    required this.body,
    this.onTap,
    this.aboveButtonWidget,
    required this.icon,
    this.shimmer = false,
    this.iconSize,
    this.resizeToAvoidBottomInsets = false,
    this.title = "Title",
    this.description = "Description",
    this.isActive = true,
    required this.buttonText,
  });

  @override
  State<MutableInputPanel> createState() => _MutableInputPanelState();
}

class _MutableInputPanelState extends State<MutableInputPanel> {
  late MediaQueryData queryData;
  late ValueNotifier<double> notifier;

  // Used to position body to be visible by keyboard
  GlobalKey key = GlobalKey();
  double spacerSize = 0;

  // Creates a render box to define size of the spacer
  void fetchSpacerSize() {
    if (key.currentContext != null) {
      RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

      spacerSize = box.size.height;
    }
  }

  // Runs mathematical ratios to animate bottom insets when keyboard is focused
  double animate(double value) {
    double centerToScreenBottom =
        spacerSize + kLargeButtonHeight + kBottomScreenMargin;

    // Finds difference space needed to reach keyboard height
    double difference = (kKeyboardHeight - centerToScreenBottom);

    // Adds a margin between keyboard and body
    double increment = kObjectKeyboardMargin + difference;

    // Using ratios to provide a parralel animation
    double push = (increment / kKeyboardHeight) * value;

    return spacerSize + push;
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    // Listens to bottom insets (keyboard) to update layout
    notifier = ValueNotifier(queryData.viewInsets.bottom);
    fetchSpacerSize();

    return OrientationBuilder(
      builder: (_, orientation) => orientation == Orientation.landscape
          ? SizedBox()
          : Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(
                kSideScreenMargin,
                kHandleTopMargin,
                kSideScreenMargin,
                kBottomScreenMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: MutableHandle()),
                  SizedBox(height: 38),
                  Center(
                    child: MutableIconSphere(
                      widget.icon,
                      size: widget.iconSize,
                    ),
                  ),
                  SizedBox(height: 32),
                  MutableText(
                    widget.title,
                    style: TypeStyle.h3,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  MutableText(
                    widget.description,
                    style: TypeStyle.h5,
                    color: MutableColor.neutral2,
                    align: TextAlign.center,
                  ),
                  Spacer(),
                  widget.body,
                  widget.resizeToAvoidBottomInsets
                      ? ValueListenableBuilder<double>(
                          valueListenable: notifier,
                          builder: (context, value, _) {
                            if (value == 0) {
                              return Spacer(key: key);
                            } else {
                              return SizedBox(height: animate(value));
                            }
                          },
                        )
                      : Spacer(),
                  widget.aboveButtonWidget == null
                      ? SizedBox()
                      : widget.aboveButtonWidget!,
                  MutableLargeButton(
                    onTap: widget.onTap,
                    text: widget.buttonText,
                    isActive: widget.isActive,
                    shimmer: widget.shimmer,
                  ),
                ],
              ),
            ),
    );
  }
}
