import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/movie_app.dart';

void main() {
  testWidgets('renders the Figma-based home screen', (tester) async {
    await tester.pumpWidget(const MovieApp());

    expect(find.text('Trending'), findsOneWidget);
    expect(find.text('Movies'), findsWidgets);
  });
}
