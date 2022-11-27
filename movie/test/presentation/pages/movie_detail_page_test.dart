import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import '../../dummy_data/movie_dummy_objects.dart';
import '../../helpers/fake_test_helper.dart';

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    mockMovieDetailBloc = MockMovieDetailBloc();

    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();

    registerFallbackValue(MovieRecommendationEventFake());
    registerFallbackValue(MovieRecommendationStateFake());
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => mockMovieDetailBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => mockMovieWatchlistBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => mockMovieRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockMovieWatchlistBloc.close();
    mockMovieWatchlistBloc.close();
    mockMovieRecommendationBloc.close();
  });
  const testId = 1;

  testWidgets(
      'when application is loading should be display circular loading progress',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMoviesLoading());
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('when application is loaded should be display widget required',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMoviesHasData(testMovieList));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));

    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });

  testWidgets(
      'when movie is added to watchlist should display check icon on button watchlist',
      (WidgetTester widgetTester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await widgetTester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: testId)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'when movie is not add to watchlist should display add icon on button watchlist ',
      (WidgetTester widgetTester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await widgetTester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: testId)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('when movie add to watchlist should display snackbar',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieIsAddedToWatchlist(true));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMovieMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: testId)));
    await tester.pump();
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
