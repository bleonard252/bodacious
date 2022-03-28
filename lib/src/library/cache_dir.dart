import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getCacheDirectory([String? subdir]) async {
  // this is in its own function so I can figure out how to get 
  return (await getTemporaryDirectory()).uri.resolve(subdir ?? ".").path;
}