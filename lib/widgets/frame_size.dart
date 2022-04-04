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

class Queue<T> {
  /// The entries in this queue.
  final List<T> entries;
  /// The current position of the queue.
  final int? position;

  Queue({
    required this.entries,
    this.position
  }) : assert((position == null || position < entries.length || position == 0) && (position == null || position >= 0), "Queue position out of range");
}