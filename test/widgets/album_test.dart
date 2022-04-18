import 'dart:io';

import 'package:bodacious/models/album_data.dart';
import 'package:bodacious/widgets/cover_placeholder.dart';
import 'package:bodacious/widgets/item/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Album standard data test", (widgetTester) async {
    final album = AlbumMetadata(
      artistName: "Tyler, The Creator",
      name: "Test Album",
      year: 2000,
      coverUri: Directory.current.absolute.uri.resolve("../testfiles/michael-dziedzic-nc11Hg2ja-s-unsplash.jpg")
    );
    
    await widgetTester.pumpWidget(MaterialApp(home: Material(child: AlbumWidget(album))));
    expect(find.textContaining(album.name, findRichText: true), findsOneWidget);
    expect(find.text(album.artistName), findsOneWidget);
    expect(find.image(FileImage(File(album.coverUri!.toFilePath()))), findsOneWidget);
    expect(find.byType(CoverPlaceholder), findsNothing);
  });
  testWidgets("Album no cover test", (widgetTester) async {
    const album = AlbumMetadata(
      artistName: "Tyler, The Creator",
      name: "Test Album",
      year: 2000,
      //coverUri: Directory.current.absolute.uri.resolve("../testfiles/michael-dziedzic-nc11Hg2ja-s-unsplash.jpg")
    );
    
    await widgetTester.pumpWidget(const MaterialApp(home: Material(child: AlbumWidget(album))));
    expect(find.textContaining(album.name, findRichText: true), findsOneWidget);
    expect(find.text(album.artistName), findsOneWidget);
    expect(find.byType(CoverPlaceholder), findsOneWidget);
  });
}