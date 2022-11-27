import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import '../../helpers/fake_test_helper.dart';

void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUpAll(() {
    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  tearDown(() {
    mockMoviePopularBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (context) => mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.state).thenReturn(PopularMoviesLoading());
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMoviesHasData(const <Movie>[]));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.state).thenReturn(PopularMoviesLoading());
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMoviesError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));
    expect(textFinder, findsOneWidget);
  });
}
