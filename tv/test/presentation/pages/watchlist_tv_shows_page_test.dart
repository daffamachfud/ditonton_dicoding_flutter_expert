import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/presentation/bloc/watchlist_tv_shows/watchlist_tv_shows_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_shows/watchlist_tv_shows_state.dart';
import 'package:tv/presentation/pages/watchlist_tv_show_page.dart';

import '../../helpers/fake_test_helper.dart';

void main() {
  late MockTvShowWatchlistBloc mockTvShowWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(TvShowWatchlistEventFake());
    registerFallbackValue(TvShowWatchlistStateFake());
    mockTvShowWatchlistBloc = MockTvShowWatchlistBloc();
  });

  tearDown(() {
    mockTvShowWatchlistBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvShowsBloc>(
      create: (context) => mockTvShowWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(WatchlistTvShowsLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowPage()));
    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(WatchlistTvShowsLoading());
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(WatchlistTvShowsHasData(const <TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockTvShowWatchlistBloc.state)
            .thenReturn(WatchlistTvShowsError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowPage()));
        expect(textFinder, findsOneWidget);
      });
}
