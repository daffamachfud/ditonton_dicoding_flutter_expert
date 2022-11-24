import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class TvShowRecommendationBloc
    extends Bloc<TvShowRecommendationEvent, TvShowRecommendationState> {
  final GetTvShowRecommendations _getTvShowRecommendations;

  TvShowRecommendationBloc(this._getTvShowRecommendations)
      : super(TvShowRecommendationEmpty()) {
    on<OnTvShowRecommendationCalled>(_onTvShowRecommendationCalled);
  }

  FutureOr<void> _onTvShowRecommendationCalled(
    OnTvShowRecommendationCalled event,
    Emitter<TvShowRecommendationState> emit,
  ) async {
    final id = event.id;
    emit(TvShowRecommendationLoading());

    final result = await _getTvShowRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TvShowRecommendationError(failure.message));
      },
      (data) {
        emit(TvShowRecommendationHasData(data));
      },
    );
  }
}
