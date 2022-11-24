import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class TopRatedTvShowsBloc
    extends Bloc<TopRatedTvShowsEvent, TopRatedTvShowsState> {
  final GetTopRatedTvs _getTopRatedTvShows;

  TopRatedTvShowsBloc(this._getTopRatedTvShows)
      : super(TopRatedTvShowsEmpty()) {
    on<OnTopRatedTvShowsCalled>(_onTopRatedTvShowsCalled);
  }

  FutureOr<void> _onTopRatedTvShowsCalled(
    OnTopRatedTvShowsCalled event,
    Emitter<TopRatedTvShowsState> emit,
  ) async {
    emit(TopRatedTvShowsLoading());

    final result = await _getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TopRatedTvShowsEmpty())
            : emit(TopRatedTvShowsHasData(data));
      },
    );
  }
}
