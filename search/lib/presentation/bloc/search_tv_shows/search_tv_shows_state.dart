import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class SearchTvShowsState extends Equatable {}

class SearchTvShowsEmpty extends SearchTvShowsState {
  @override
  List<Object?> get props => [];
}

class SearchTvShowsLoading extends SearchTvShowsState {
  @override
  List<Object?> get props => [];
}

class SearchTvShowsError extends SearchTvShowsState {
  final String message;

  SearchTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvShowsHasData extends SearchTvShowsState {
  final List<TvShow> result;

  SearchTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
