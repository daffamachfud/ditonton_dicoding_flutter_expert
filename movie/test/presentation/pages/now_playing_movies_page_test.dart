import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../helpers/fake_test_helper.dart';

void main() {
  late MockMovieNowPlayingBloc mockMovieNowPlayingBloc;

  setUpAll(() {
    registerFallbackValue(MovieNowPlayingEventFake());
    registerFallbackValue(MovieNowPlayingStateFake());
    mockMovieNowPlayingBloc = MockMovieNowPlayingBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (_) => mockMovieNowPlayingBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockMovieNowPlayingBloc.close();
  });

  testWidgets('should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMovieNowPlayingBloc.state)
        .thenReturn(NowPlayingMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingMoviePage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display ListView when data is loaded',
      (WidgetTester tester) async {
        when(() => mockMovieNowPlayingBloc.state)
            .thenReturn(NowPlayingMoviesLoading());
        when(() => mockMovieNowPlayingBloc.state)
            .thenReturn(NowPlayingMoviesHasData(const <Movie>[]));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(NowPlayingMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
        when(() => mockMovieNowPlayingBloc.state)
            .thenReturn(NowPlayingMoviesLoading());
        when(() => mockMovieNowPlayingBloc.state)
            .thenReturn(NowPlayingMoviesError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingMoviePage()));

    expect(textFinder, findsOneWidget);
  });
}
