import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class TopRatedTvShowsState extends Equatable {}

class TopRatedTvShowsEmpty extends TopRatedTvShowsState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvShowsLoading extends TopRatedTvShowsState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvShowsError extends TopRatedTvShowsState {
  final String message;

  TopRatedTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvShowsHasData extends TopRatedTvShowsState {
  final List<TvShow> result;

  TopRatedTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
