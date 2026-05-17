import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/movie_app.dart';

void main() {
  testWidgets('renders the app shell', (tester) async {
    await tester.pumpWidget(const MovieApp());
    await tester.pump();

    expect(find.byType(MovieApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
