import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/fake_test_helper.dart';

void main() {
  late MockTvShowDetailBloc mockTvShowDetailBloc;
  late MockTvShowWatchlistBloc mockTvShowWatchlistBloc;
  late MockTvShowRecommendationBloc mockTvShowRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(TvShowDetailEventFake());
    registerFallbackValue(TvShowDetailStateFake());
    mockTvShowDetailBloc = MockTvShowDetailBloc();

    registerFallbackValue(TvShowWatchlistEventFake());
    registerFallbackValue(TvShowWatchlistStateFake());
    mockTvShowWatchlistBloc = MockTvShowWatchlistBloc();

    registerFallbackValue(TvShowRecommendationEventFake());
    registerFallbackValue(TvShowRecommendationStateFake());
    mockTvShowRecommendationBloc = MockTvShowRecommendationBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowDetailBloc>(
          create: (_) => mockTvShowDetailBloc,
        ),
        BlocProvider<WatchlistTvShowsBloc>(
          create: (_) => mockTvShowWatchlistBloc,
        ),
        BlocProvider<TvShowRecommendationBloc>(
          create: (_) => mockTvShowRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockTvShowDetailBloc.close();
    mockTvShowWatchlistBloc.close();
    mockTvShowRecommendationBloc.close();
  });
  const testId = 1;

  testWidgets(
      'when application is loading should be display circular loading progress',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state).thenReturn(TvShowDetailLoading());
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(WatchlistTvShowsLoading());
    when(() => mockTvShowRecommendationBloc.state)
        .thenReturn(TvShowRecommendationLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('when application is loaded should be display widget required',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(WatchlistTvShowsHasData(testTvShowList));
    when(() => mockTvShowRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(
      id: testId,
    )));

    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });

  testWidgets(
      'when tv show is added to watchlist should display check icon on button watchlist',
      (WidgetTester widgetTester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(TvShowIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await widgetTester
        .pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: testId)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'when tv is not add to watchlist should display add icon on button watchlist ',
      (WidgetTester widgetTester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await widgetTester
        .pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: testId)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('when tv add to watchlist should display snackbar',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(TvShowIsAddedToWatchlist(true));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(WatchlistTvShowMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: testId)));
    await tester.pump();
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
