import 'package:shared_preferences/shared_preferences.dart';

class Config {
  final SharedPreferences _prefs;
  Config(this._prefs);

  /// Whether or not to use the Android system library instead of
  /// the Bodacious library.
  /// This should turn off the indexer and 
  bool get useSystemLibrary => _prefs.getBool("use-system-library") ?? false;
  Future<void> setUseSystemLibrary(bool to) => _prefs.setBool("use-system-library", to);
  /// **NOTE: This is an unmodifiable list!**
  /// To change it:
  /// ```dart
  /// config.libraries = List.from(config.libraries)
  /// ..add("string");
  /// ```
  List<String> get libraries => List.unmodifiable(_prefs.getStringList("libraries") ?? []);
  Future<void> setLibraries(List<String> to) => _prefs.setStringList("librarieslibrary", to);
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
    
  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      throw UnsupportedError("Cannot modify read-only config");
    }
    return super.noSuchMethod(invocation);
  }
}