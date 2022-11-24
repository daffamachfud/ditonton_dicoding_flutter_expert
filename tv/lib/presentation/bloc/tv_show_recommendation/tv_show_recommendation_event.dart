import 'package:equatable/equatable.dart';

abstract class TvShowRecommendationEvent extends Equatable {}

class OnTvShowRecommendationCalled extends TvShowRecommendationEvent {
  final int id;

  OnTvShowRecommendationCalled(this.id);

  @override
  List<Object> get props => [];
}
