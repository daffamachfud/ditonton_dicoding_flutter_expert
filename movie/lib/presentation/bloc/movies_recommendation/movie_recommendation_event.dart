import 'package:equatable/equatable.dart';

abstract class MovieRecommendationEvent extends Equatable {}

class OnMovieRecommendationCalled extends MovieRecommendationEvent {
  final int id;

  OnMovieRecommendationCalled(this.id);

  @override
  List<Object> get props => [];
}