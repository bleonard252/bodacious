import 'package:shared_preferences/shared_preferences.dart';

class Config {
  final SharedPreferences _prefs;
  Config(this._prefs);

  /// Whether or not to use the Android system library instead of
  /// the Bodacious library.
  /// This should turn off the indexer and 
  bool get useSystemLibrary => _prefs.getBool("use-system-library") ?? false;
  set useSystemLibrary(bool to) => _prefs.setBool("use-system-library", to);
  /// **NOTE: This is an unmodifiable list!**
  /// To change it:
  /// ```dart
  /// config.libraries = List.from(config.libraries)
  /// ..add("string");
  /// ```
  List<String> get libraries => List.unmodifiable(_prefs.getStringList("libraries") ?? []);
  set libraries(List<String> to) => _prefs.setStringList("libraries", to);
}

class ROConfig implements Config {
  @override
  List<String> libraries;

  @override
  bool useSystemLibrary;

  @override
  SharedPreferences get _prefs => throw UnsupportedError("Not necessary");

  ROConfig(Config config) :
    libraries = config.libraries,
    useSystemLibrary = config.useSystemLibrary;
}