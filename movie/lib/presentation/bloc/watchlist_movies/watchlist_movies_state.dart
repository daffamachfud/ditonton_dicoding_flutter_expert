import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

abstract class WatchlistMoviesState extends Equatable {}

class WatchlistMoviesEmpty extends WatchlistMoviesState {
  @override
  List<Object?> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  @override
  List<Object?> get props => [];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;

  WatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieIsAddedToWatchlist extends WatchlistMoviesState {
  final bool isAdded;

  MovieIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistMovieMessage extends WatchlistMoviesState {
  final String message;

  WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}
