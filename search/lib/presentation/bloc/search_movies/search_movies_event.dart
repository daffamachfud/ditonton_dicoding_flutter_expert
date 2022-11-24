import 'package:equatable/equatable.dart';

abstract class SearchMoviesEvent extends Equatable {}

class OnQueryMovieChanged extends SearchMoviesEvent {

  final String query;

  OnQueryMovieChanged(this.query);

  @override
  List<Object> get props => [];
}
