
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

abstract class PopularMoviesState extends Equatable {}

class PopularMoviesEmpty extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> result;

  PopularMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
