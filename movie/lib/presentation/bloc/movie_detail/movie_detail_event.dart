  import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {}

class OnMovieDetailCalled extends MovieDetailEvent {
  final int id;

  OnMovieDetailCalled(this.id);

  @override
  List<Object> get props => [];
}