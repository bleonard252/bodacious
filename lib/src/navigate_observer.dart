import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NavigationNotifier extends NavigatorObserver {
  final StreamController<int> _stream = StreamController();
  /// The stream attached to this NavigationNotifier.
  get stream => _stream.stream;

  @override
  void didPush(Route route, Route? previousRoute) {
    pageChanged();
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    pageChanged();
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    pageChanged();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    pageChanged();
    super.didPop(route, previousRoute);
  }

  void pageChanged() {
    _stream.add(0);
  }
}

extension GoRouterCanPop on GoRouter {
  bool canPop() => (Uri.parse(location).pathSegments.isNotEmpty) || (navigator?.canPop() ?? false);
}