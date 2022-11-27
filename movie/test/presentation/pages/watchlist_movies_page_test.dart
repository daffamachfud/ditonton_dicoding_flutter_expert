import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../helpers/fake_test_helper.dart';

void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  tearDown(() {
    mockMovieWatchlistBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>(
      create: (context) => mockMovieWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMoviesLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMoviesLoading());
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMoviesHasData(const <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(WatchlistMoviesError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    expect(textFinder, findsOneWidget);
  });
}
