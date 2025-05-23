import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lab_assignment_3/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab_assignment_3/data/api_service.dart';
import 'package:flutter_lab_assignment_3/data/album_repository.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    final repo = AlbumRepository(ApiService());
    await tester.pumpWidget(MyApp(albumRepository: repo));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}