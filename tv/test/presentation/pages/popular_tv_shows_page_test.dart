import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv/tv.dart';

import '../../helpers/fake_test_helper.dart';

void main() {
  late MockTvShowPopularBloc mockTvShowPopularBloc;

  setUpAll(() {
    registerFallbackValue(TvShowPopularEventFake());
    registerFallbackValue(TvShowPopularStateFake());
    mockTvShowPopularBloc = MockTvShowPopularBloc();
  });

  tearDown(() {
    mockTvShowPopularBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvShowsBloc>(
      create: (context) => mockTvShowPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvShowPopularBloc.state).thenReturn(PopularTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvShowPopularBloc.state).thenReturn(PopularTvShowsLoading());
    when(() => mockTvShowPopularBloc.state)
        .thenReturn(PopularTvShowsHasData(const <TvShow>[]));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvShowPopularBloc.state).thenReturn(PopularTvShowsLoading());
    when(() => mockTvShowPopularBloc.state)
        .thenReturn(PopularTvShowsError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));
    expect(textFinder, findsOneWidget);
  });
}
