import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

//detail
class TvShowDetailEventFake extends Fake implements TvShowDetailEvent {}

class TvShowDetailStateFake extends Fake implements TvShowDetailState {}

class MockTvShowDetailBloc
    extends MockBloc<TvShowDetailEvent, TvShowDetailState>
    implements TvShowDetailBloc {}

//recommendation
class TvShowRecommendationEventFake extends Fake implements TvShowDetailEvent {}

class TvShowRecommendationStateFake extends Fake implements TvShowDetailState {}

class MockTvShowRecommendationBloc
    extends MockBloc<TvShowRecommendationEvent, TvShowRecommendationState>
    implements TvShowRecommendationBloc {}

//now playing
class TvShowNowPlayingEventFake extends Fake implements NowPlayingTvShowsEvent {
}

class TvShowNowPlayingStateFake extends Fake implements NowPlayingTvShowsState {
}

class MockTvShowNowPlayingBloc
    extends MockBloc<NowPlayingTvShowsEvent, NowPlayingTvShowsState>
    implements NowPlayingTvShowsBloc {}

//popular
class TvShowPopularEventFake extends Fake implements PopularTvShowsEvent {}

class TvShowPopularStateFake extends Fake implements PopularTvShowsState {}

class MockTvShowPopularBloc
    extends MockBloc<PopularTvShowsEvent, PopularTvShowsState>
    implements PopularTvShowsBloc {}

//top rated
class TvShowTopRatedEventFake extends Fake implements TopRatedTvShowsEvent {}

class TvShowTopRatedStateFake extends Fake implements TopRatedTvShowsState {}

class MockTvShowTopRatedBloc
    extends MockBloc<TopRatedTvShowsEvent, TopRatedTvShowsState>
    implements TopRatedTvShowsBloc {}

//watchlist
class TvShowWatchlistEventFake extends Fake implements WatchlistTvShowsEvent {}

class TvShowWatchlistStateFake extends Fake implements WatchlistTvShowsState {}

class MockTvShowWatchlistBloc
    extends MockBloc<WatchlistTvShowsEvent, WatchlistTvShowsState>
    implements WatchlistTvShowsBloc {}
