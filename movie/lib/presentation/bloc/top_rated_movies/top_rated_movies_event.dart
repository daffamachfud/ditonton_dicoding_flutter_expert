import 'package:equatable/equatable.dart';

abstract class TopRatedMoviesEvent extends Equatable {}

class OnTopRatedMoviesCalled extends TopRatedMoviesEvent {
  @override
  List<Object> get props => [];
}
