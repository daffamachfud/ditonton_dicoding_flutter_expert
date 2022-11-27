import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

//detail
class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

//recommendation
class MovieRecommendationEventFake extends Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake
    implements MovieRecommendationState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

//now playing
class MovieNowPlayingEventFake extends Fake implements NowPlayingMoviesEvent {}

class MovieNowPlayingStateFake extends Fake implements NowPlayingMoviesState {}

class MockMovieNowPlayingBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

//popular
class MoviePopularEventFake extends Fake implements PopularMoviesEvent {}

class MoviePopularStateFake extends Fake implements PopularMoviesState {}

class MockMoviePopularBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

//top rated
class MovieTopRatedEventFake extends Fake implements TopRatedMoviesEvent {}

class MovieTopRatedStateFake extends Fake implements TopRatedMoviesState {}

class MockMovieTopRatedBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

//watchlist
class MovieWatchlistEventFake extends Fake implements WatchlistMoviesEvent {}

class MovieWatchlistStateFake extends Fake implements WatchlistMoviesState {}

class MockMovieWatchlistBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}
