import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class WatchlistTvShowsEvent extends Equatable {}

class OnWatchlistTvShowsCalled extends WatchlistTvShowsEvent {
  @override
  List<Object> get props => [];
}

class OnWatchlistTvShowStatusCalled extends WatchlistTvShowsEvent {
  final int id;

  OnWatchlistTvShowStatusCalled(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddTvShowToWatchlistCalled extends WatchlistTvShowsEvent {
  final TvShowDetail tvShow;

  OnAddTvShowToWatchlistCalled(this.tvShow);

  @override
  List<Object> get props => [TvShow];
}

class OnRemoveTvShowWatchlistCalled extends WatchlistTvShowsEvent {
  final TvShowDetail tvShow;

  OnRemoveTvShowWatchlistCalled(this.tvShow);

  @override
  List<Object> get props => [TvShow];
}
