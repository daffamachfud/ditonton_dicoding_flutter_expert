import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<OnMovieRecommendationCalled>(_onMovieRecommendationCalled);
  }

  FutureOr<void> _onMovieRecommendationCalled(
    OnMovieRecommendationCalled event,
    Emitter<MovieRecommendationState> emit,
  ) async {
    final id = event.id;
    emit(MovieRecommendationLoading());

    final result = await _getMovieRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(MovieRecommendationError(failure.message));
      },
      (data) {
        emit(MovieRecommendationHasData(data));
      },
    );
  }
}
