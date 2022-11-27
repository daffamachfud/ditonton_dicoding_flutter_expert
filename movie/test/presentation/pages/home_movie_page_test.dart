import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import '../../dummy_data/movie_dummy_objects.dart';
import '../../helpers/fake_test_helper.dart';

void main() {
  late MockMovieNowPlayingBloc mockMovieNowPlayingBloc;
  late MockMoviePopularBloc mockMoviePopularBloc;
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(MovieNowPlayingEventFake());
    registerFallbackValue(MovieNowPlayingStateFake());
    mockMovieNowPlayingBloc = MockMovieNowPlayingBloc();

    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
    mockMoviePopularBloc = MockMoviePopularBloc();

    registerFallbackValue(MovieTopRatedEventFake());
    registerFallbackValue(MovieTopRatedStateFake());
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  tearDown(() {
    mockMovieTopRatedBloc.close();
    mockMoviePopularBloc.close();
    mockMovieNowPlayingBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => mockMovieNowPlayingBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockMoviePopularBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => mockMovieTopRatedBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'should display listview of now playing movie when has data state occurred',
      (tester) async {
    when(() => mockMovieNowPlayingBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => mockMovieTopRatedBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('should display error text when error', (tester) async {
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMoviesLoading());
    when(() => mockMoviePopularBloc.state)
        .thenReturn(PopularMoviesError('error'));
    when(() => mockMovieNowPlayingBloc.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => mockMovieNowPlayingBloc.state)
        .thenReturn(NowPlayingMoviesError('error'));
    when(() => mockMovieTopRatedBloc.state)
        .thenReturn(TopRatedMoviesLoading());
    when(() => mockMovieTopRatedBloc.state)
        .thenReturn(TopRatedMoviesError('error'));

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });
}
