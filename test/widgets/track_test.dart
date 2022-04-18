import 'dart:io';

import 'package:bodacious/main.dart';
import 'package:bodacious/models/track_data.dart';
import 'package:bodacious/widgets/item/song.dart';
import 'package:flutter/material.dart' show FileImage, ListTile, Material, MaterialApp;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_player.dart';

late final mockPlayer = MockAudioHandler();
late final TrackMetadata track1 = TrackMetadata(
  uri: Directory.current.absolute.uri.resolve("../testfiles/zero.mp3"),
  coverUri: Directory.current.absolute.uri.resolve("../testfiles/michael-dziedzic-nc11Hg2ja-s-unsplash.jpg"),
  available: true,
  albumName: "Test Album",
  artistName: "Test Artist",
  title: "The Big Test",
  year: 2022,
  trackNo: 4
);
late final TrackMetadata track2 = track1.copyWith(available: false);
late final TrackMetadata track3 = TrackMetadata.empty();

void main() {
  setUpAll(() {
    player = mockPlayer;
  });
  group("Track available", () {
    testWidgets("Standard data test", (widgetTester) async {
      // Handle mockPlayer whens here

      await widgetTester.pumpWidget(MaterialApp(home: Material(child: SongWidget(track1))));
      expect(find.text(track1.title!), findsOneWidget);
      expect(find.text(track1.artistName!), findsOneWidget);
      expect(find.text(track1.albumName!), findsNothing);
      expect(find.textContaining(track1.trackNo!.toString()), findsNothing);
      expect(find.image(FileImage(File(track1.coverUri!.toFilePath()))), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is ListTile && widget.selected), findsNothing);
    });
    testWidgets("Selected test", (widgetTester) async {
      // Handle mockPlayer whens here

      await widgetTester.pumpWidget(MaterialApp(home: Material(child: SongWidget(track1,
        selected: true,
        showTrackNo: true,
        useAlbumName: true,
      ))));
      expect(find.text(track1.title!), findsOneWidget);
      expect(find.text(track1.artistName!), findsNothing);
      expect(find.text(track1.albumName!), findsOneWidget);
      expect(find.text("04") /* track1.trackNo! */, findsNothing);
      expect(find.byIcon(MdiIcons.equalizer), findsOneWidget);
      expect(find.image(FileImage(File(track1.coverUri!.toFilePath()))), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is ListTile && widget.selected), findsOneWidget);
    });
    testWidgets("Track number test", (widgetTester) async {
      // Handle mockPlayer whens here

      await widgetTester.pumpWidget(MaterialApp(home: Material(child: SongWidget(track1,
        selected: false,
        showTrackNo: true,
        useAlbumName: true,
      ))));
      expect(find.text(track1.title!), findsOneWidget);
      expect(find.text(track1.artistName!), findsNothing);
      expect(find.text(track1.albumName!), findsOneWidget);
      expect(find.text("04"), findsOneWidget);
      expect(find.byIcon(MdiIcons.equalizer), findsNothing);
      expect(find.image(FileImage(File(track1.coverUri!.toFilePath()))), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is ListTile && widget.selected), findsNothing);
    });
  });
  testWidgets("Track unavailable test", (widgetTester) async {
    // Handle mockPlayer whens here

      await widgetTester.pumpWidget(MaterialApp(home: Material(child: SongWidget(track2))));
      expect(find.text(track2.title!), findsOneWidget);
      expect(find.text(track2.artistName!), findsNothing);
      expect(find.text(track2.albumName!), findsNothing);
      expect(find.text("Track unavailable"), findsOneWidget);
      expect(find.textContaining(track2.trackNo!.toString()), findsNothing);
      expect(find.image(FileImage(File(track2.coverUri!.toFilePath()))), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is ListTile && widget.selected), findsNothing);
  });
}