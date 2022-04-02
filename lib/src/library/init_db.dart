import 'package:bodacious/models/track_data.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

@Deprecated("Use BoDatabase instead")
Future<Database> loadDatabase({String? boLibraryPath}) async {
  late final DatabaseFactory factory;
  late final String dbPath;
  if (kIsWeb) {
    throw UnsupportedError("Web is not supported at this time.");
  } else {
    factory = databaseFactoryIo;
  }
  if (boLibraryPath == null) {
    try {
      dbPath = (await getLibraryDirectory()).absolute.path+"/_boLibrary";
    } catch(_) {
      try {
        dbPath = (await getApplicationSupportDirectory()).absolute.path+"/_boLibrary";
      } catch(_) {
        dbPath = (await getApplicationDocumentsDirectory()).absolute.path+"/_boLibrary";
      }
    }
  }
  return await factory.openDatabase(boLibraryPath ?? dbPath);
}
