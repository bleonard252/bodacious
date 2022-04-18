import 'dart:io';

import 'package:bodacious/drift/database.dart';
import 'package:bodacious/main.dart';
import 'package:bodacious/models/artist_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/item/artist.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

late final artist1 = artist2.copyWith(
  coverUri: Directory.current.absolute.uri.resolve("../testfiles/michael-dziedzic-nc11Hg2ja-s-unsplash.jpg"),
  albumCount: 4,
  trackCount: 8
);
const artist2 = ArtistMetadata(
  name: "Bob Ross"
);

void main() {
  testWidgets("Artist standard data test", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Material(child: ArtistWidget(artist1))));
    expect(find.byType(ClipOval), findsOneWidget); // artists should have clipOval
    expect(find.text(artist1.name, findRichText: true), findsOneWidget);
    expect(find.textContaining("4 albums"), findsOneWidget);
    expect(find.image(FileImage(File(artist1.coverUri!.toFilePath()))), findsOneWidget);
    expect(find.byType(CoverPlaceholder), findsNothing);
  });
  testWidgets("Artist empty test", (widgetTester) async {
    // Due to the database lookup we have to initialize a database for this test.
    db = BoDatabase.fromExecutor(NativeDatabase.memory());
    await widgetTester.pumpWidget(const MaterialApp(home: Material(child: ArtistWidget(artist2))));
    expect(find.text(artist2.name), findsOneWidget);
    expect(find.textContaining("0 albums"), findsNothing);
    expect(find.byType(CoverPlaceholder), findsOneWidget);
  });
}