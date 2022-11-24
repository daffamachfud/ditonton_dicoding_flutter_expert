import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

abstract class WatchlistMoviesEvent extends Equatable {}

class OnWatchlistMoviesCalled extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}

class OnWatchlistMovieStatusCalled extends WatchlistMoviesEvent {
  final int id;

  OnWatchlistMovieStatusCalled(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddMovieToWatchlistCalled extends WatchlistMoviesEvent {
  final MovieDetail movie;

  OnAddMovieToWatchlistCalled(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveMovieWatchlistCalled extends WatchlistMoviesEvent {
  final MovieDetail movie;

  OnRemoveMovieWatchlistCalled(this.movie);

  @override
  List<Object> get props => [movie];
}
