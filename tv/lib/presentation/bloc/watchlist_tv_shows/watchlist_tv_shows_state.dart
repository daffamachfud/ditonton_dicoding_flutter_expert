import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class WatchlistTvShowsState extends Equatable {}

class WatchlistTvShowsEmpty extends WatchlistTvShowsState {
  @override
  List<Object?> get props => [];
}

class WatchlistTvShowsLoading extends WatchlistTvShowsState {
  @override
  List<Object?> get props => [];
}

class WatchlistTvShowsError extends WatchlistTvShowsState {
  final String message;

  WatchlistTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowsHasData extends WatchlistTvShowsState {
  final List<TvShow> result;

  WatchlistTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowIsAddedToWatchlist extends WatchlistTvShowsState {
  final bool isAdded;

  TvShowIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistTvShowMessage extends WatchlistTvShowsState {
  final String message;

  WatchlistTvShowMessage(this.message);

  @override
  List<Object> get props => [message];
}
