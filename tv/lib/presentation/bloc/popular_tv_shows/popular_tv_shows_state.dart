import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class PopularTvShowsState extends Equatable {}

class PopularTvShowsEmpty extends PopularTvShowsState {
  @override
  List<Object?> get props => [];
}

class PopularTvShowsLoading extends PopularTvShowsState {
  @override
  List<Object?> get props => [];
}

class PopularTvShowsError extends PopularTvShowsState {
  final String message;

  PopularTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvShowsHasData extends PopularTvShowsState {
  final List<TvShow> result;

  PopularTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
