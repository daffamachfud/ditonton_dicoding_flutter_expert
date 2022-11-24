import 'package:equatable/equatable.dart';

abstract class NowPlayingTvShowsEvent extends Equatable {}

class OnNowPlayingTvShowsCalled extends NowPlayingTvShowsEvent {
  @override
  List<Object> get props => [];
}
