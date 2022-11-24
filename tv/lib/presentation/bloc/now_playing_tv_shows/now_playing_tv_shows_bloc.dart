import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class NowPlayingTvShowsBloc
    extends Bloc<NowPlayingTvShowsEvent, NowPlayingTvShowsState> {
  final GetNowPlayingTvs _getNowPlayingTvShows;

  NowPlayingTvShowsBloc(this._getNowPlayingTvShows)
      : super(NowPlayingTvShowsEmpty()) {
    on<OnNowPlayingTvShowsCalled>(_onNowPlayingTvShowsCalled);
  }

  FutureOr<void> _onNowPlayingTvShowsCalled(
    OnNowPlayingTvShowsCalled event,
    Emitter<NowPlayingTvShowsState> emit,
  ) async {
    emit(NowPlayingTvShowsLoading());

    final result = await _getNowPlayingTvShows.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(NowPlayingTvShowsEmpty())
            : emit(NowPlayingTvShowsHasData(data));
      },
    );
  }
}
