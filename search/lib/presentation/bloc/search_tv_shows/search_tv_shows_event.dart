import 'package:equatable/equatable.dart';

abstract class SearchTvShowsEvent extends Equatable {}

class OnQueryTvShowChanged extends SearchTvShowsEvent {

  final String query;

  OnQueryTvShowChanged(this.query);

  @override
  List<Object> get props => [];
}
