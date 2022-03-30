import 'package:bodacious/src/metadata/infer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Infer from URI: three parts, no #', () {
    final actual = inferMetadataFromContext(Uri.file("/home/user/music/Imagine Dragons - Night Visions - Radioactive.mp3", windows: false));
    expect(actual.artistName, "Imagine Dragons");
    expect(actual.albumName, "Night Visions");
    expect(actual.title, "Radioactive");
    expect(actual.trackNo, null, reason: "No track number was provided, so none should be set.");
  });
  test('Infer from URI: three parts, tr# with space', () {
    final actual = inferMetadataFromContext(Uri.file("/home/user/music/Imagine Dragons - Night Visions - 03 It's Time.mp3", windows: false));
    expect(actual.artistName, "Imagine Dragons");
    expect(actual.albumName, "Night Visions");
    expect(actual.title, "It's Time");
    expect(actual.trackNo, 3);
  });
  test('Infer from URI: three levels, no #', () {
    final actual = inferMetadataFromContext(Uri.file("/home/user/music/Linkin Park/LIVING THINGS/CASTLE OF GLASS.ogg", windows: false));
    expect(actual.artistName, "Linkin Park");
    expect(actual.albumName, "LIVING THINGS");
    expect(actual.title, "CASTLE OF GLASS");
    expect(actual.trackNo, null, reason: "No track number was provided, so none should be set.");
  });
  test('Infer from URI: three levels, tr# with hyphen', () {
    final actual = inferMetadataFromContext(Uri.file("/home/user/music/Linkin Park/LIVING THINGS/03- BURN IT DOWN.ogg", windows: false));
    expect(actual.artistName, "Linkin Park");
    expect(actual.albumName, "LIVING THINGS");
    expect(actual.title, "BURN IT DOWN");
    expect(actual.trackNo, 3);
  });
  test('Infer from URI: Two part Windows path, tr# with dot', () {
    // The URI has to be set to use Windows semantics
    // because I'm running Linux and it detects automatically.
    // Which should work just fine on Windows.
    final actual = inferMetadataFromContext(Uri.file(r"D:\Music\Katy Perry - Teenage Dream\4. Firework.ogg", windows: true));
    expect(actual.artistName, "Katy Perry");
    expect(actual.albumName, "Teenage Dream");
    expect(actual.title, "Firework");
    expect(actual.trackNo, 4);
  });
}