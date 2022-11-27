import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';
import 'package:tv/presentation/widgets/tv_show_card_list.dart';

import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Material(child: body),
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (ctx) => MovieCard(testMovie)),
    );
  }

  testWidgets('should display info movie card', (WidgetTester tester) async {
    final clip = find.byType(ClipRRect);
    final inkwell = find.byType(InkWell);
    await tester.pumpWidget(
      _makeTestableWidget(
        MovieCard(testMovie),
      ),
    );

    expect(clip, findsOneWidget);
    await tester.tap(inkwell);
  });
}