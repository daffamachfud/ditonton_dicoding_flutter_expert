import 'package:equatable/equatable.dart';

abstract class NowPlayingMoviesEvent extends Equatable {}

class OnNowPlayingMoviesCalled extends NowPlayingMoviesEvent {
  @override
  List<Object> get props => [];
}
