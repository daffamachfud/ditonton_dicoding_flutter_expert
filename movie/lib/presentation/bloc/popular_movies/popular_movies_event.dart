import 'package:equatable/equatable.dart';

abstract class PopularMoviesEvent extends Equatable {}

class OnPopularMoviesCalled extends PopularMoviesEvent {
  @override
  List<Object> get props => [];
}
