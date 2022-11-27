import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/widgets/tv_show_card_list.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Material(child: body),
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (ctx) => TvShowCard(testTvShow)),
    );
  }

  testWidgets('should display info tv show card path', (WidgetTester tester) async {
    final clip = find.byType(ClipRRect);
    final inkwell = find.byType(InkWell);
    await tester.pumpWidget(
      _makeTestableWidget(
        TvShowCard(testTvShow),
      ),
    );

    expect(clip, findsOneWidget);
    await tester.tap(inkwell);
  });
}