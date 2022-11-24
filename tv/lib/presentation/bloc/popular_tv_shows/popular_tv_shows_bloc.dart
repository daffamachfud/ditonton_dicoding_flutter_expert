import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class PopularTvShowsBloc
    extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvs _getPopularTvShows;

  PopularTvShowsBloc(this._getPopularTvShows) : super(PopularTvShowsEmpty()) {
    on<OnPopularTvShowsCalled>(_onPopularTvShowsCalled);
  }

  FutureOr<void> _onPopularTvShowsCalled(
    OnPopularTvShowsCalled event,
    Emitter<PopularTvShowsState> emit,
  ) async {
    emit(PopularTvShowsLoading());

    final result = await _getPopularTvShows.execute();

    result.fold(
      (failure) {
        emit(PopularTvShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(PopularTvShowsEmpty())
            : emit(PopularTvShowsHasData(data));
      },
    );
  }
}
