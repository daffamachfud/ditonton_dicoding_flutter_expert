import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class NowPlayingTvShowsState extends Equatable {}

class NowPlayingTvShowsEmpty extends NowPlayingTvShowsState {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowsLoading extends NowPlayingTvShowsState {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowsError extends NowPlayingTvShowsState {
  final String message;

  NowPlayingTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvShowsHasData extends NowPlayingTvShowsState {
  final List<TvShow> result;

  NowPlayingTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
