import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../helpers/fake_test_helper.dart';

void main() {
  late MockTvShowNowPlayingBloc mockTvShowNowPlayingBloc;

  setUpAll(() {
    registerFallbackValue(TvShowNowPlayingEventFake());
    registerFallbackValue(TvShowNowPlayingStateFake());
    mockTvShowNowPlayingBloc = MockTvShowNowPlayingBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvShowsBloc>(
          create: (_) => mockTvShowNowPlayingBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockTvShowNowPlayingBloc.close();
  });

  testWidgets('should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsLoading());
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsHasData(const <TvShow>[]));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsLoading());
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
