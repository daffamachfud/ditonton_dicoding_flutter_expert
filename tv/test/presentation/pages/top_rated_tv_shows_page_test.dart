import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_state.dart';
import 'package:tv/presentation/pages/top_rated_tv_show_page.dart';

import '../../helpers/fake_test_helper.dart';

void main() {
  late MockTvShowTopRatedBloc mockTvShowTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TvShowTopRatedEventFake());
    registerFallbackValue(TvShowTopRatedStateFake());
    mockTvShowTopRatedBloc = MockTvShowTopRatedBloc();
  });

  tearDown(() {
    mockTvShowTopRatedBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvShowsBloc>(
      create: (context) => mockTvShowTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));
    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsLoading());
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsHasData(const <TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
