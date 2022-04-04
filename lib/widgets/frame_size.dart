import 'package:flutter/widgets.dart';

class FrameSize extends InheritedWidget {
  final Widget child;
  final bool largeFrame;
  FrameSize({
    Key? key,
    required this.largeFrame,
    required this.child
  }) : super(key: key, child: child);
  
  @override
  bool updateShouldNotify(covariant FrameSize oldWidget) {
    return oldWidget.largeFrame != largeFrame;
  }

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FrameSize>()!.largeFrame;
  }
  
}