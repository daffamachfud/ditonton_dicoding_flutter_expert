import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/fake_test_helper.dart';

void main() {
  late MockTvShowNowPlayingBloc mockTvShowNowPlayingBloc;
  late MockTvShowPopularBloc mockTvShowPopularBloc;
  late MockTvShowTopRatedBloc mockTvShowTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TvShowWatchlistEventFake());
    registerFallbackValue(TvShowWatchlistStateFake());
    mockTvShowNowPlayingBloc = MockTvShowNowPlayingBloc();

    registerFallbackValue(TvShowPopularEventFake());
    registerFallbackValue(TvShowPopularStateFake());
    mockTvShowPopularBloc = MockTvShowPopularBloc();

    registerFallbackValue(TvShowTopRatedEventFake());
    registerFallbackValue(TvShowTopRatedStateFake());
    mockTvShowTopRatedBloc = MockTvShowTopRatedBloc();
  });

  tearDown(() {
    mockTvShowTopRatedBloc.close();
    mockTvShowNowPlayingBloc.close();
    mockTvShowPopularBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvShowsBloc>(
          create: (context) => mockTvShowNowPlayingBloc,
        ),
        BlocProvider<PopularTvShowsBloc>(
          create: (context) => mockTvShowPopularBloc,
        ),
        BlocProvider<TopRatedTvShowsBloc>(
          create: (context) => mockTvShowTopRatedBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'should display listview of now playing tv show when has data state occurred',
      (tester) async {
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsHasData(testTvShowList));
    when(() => mockTvShowPopularBloc.state)
        .thenReturn(PopularTvShowsHasData(testTvShowList));
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsHasData(testTvShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('should display error text when error', (tester) async {
    when(() => mockTvShowPopularBloc.state).thenReturn(PopularTvShowsLoading());
    when(() => mockTvShowPopularBloc.state)
        .thenReturn(PopularTvShowsError('error'));
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsLoading());
    when(() => mockTvShowNowPlayingBloc.state)
        .thenReturn(NowPlayingTvShowsError('error'));
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsLoading());
    when(() => mockTvShowTopRatedBloc.state)
        .thenReturn(TopRatedTvShowsError('error'));

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });
}
