import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

abstract class TvShowRecommendationState extends Equatable {}

class TvShowRecommendationEmpty extends TvShowRecommendationState {
  @override
  List<Object?> get props => [];
}

class TvShowRecommendationLoading extends TvShowRecommendationState {
  @override
  List<Object?> get props => [];
}

class TvShowRecommendationError extends TvShowRecommendationState {
  final String message;

  TvShowRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowRecommendationHasData extends TvShowRecommendationState {
  final List<TvShow> result;

  TvShowRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
