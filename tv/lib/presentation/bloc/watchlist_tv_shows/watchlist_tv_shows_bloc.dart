import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class WatchlistTvShowsBloc
    extends Bloc<WatchlistTvShowsEvent, WatchlistTvShowsState> {
  final GetWatchlistTvs _getWatchlistTvShows;
  final GetWatchListTvStatus _getWatchListTvStatus;
  final RemoveTvWatchlist _removeTvWatchlist;
  final SaveTvWatchlist _saveTvWatchlist;

  WatchlistTvShowsBloc(
    this._getWatchlistTvShows,
    this._getWatchListTvStatus,
    this._removeTvWatchlist,
    this._saveTvWatchlist,
  ) : super(WatchlistTvShowsEmpty()) {
    on<OnWatchlistTvShowsCalled>(_onWatchlistTvShowsCalled);
    on<OnWatchlistTvShowStatusCalled>(_onWatchlistTvShowStatusCalled);
    on<OnAddTvShowToWatchlistCalled>(_onAddTvShowToWatchlistCalled);
    on<OnRemoveTvShowWatchlistCalled>(_onRemoveTvShowWatchlistCalled);
  }

  FutureOr<void> _onWatchlistTvShowsCalled(
    OnWatchlistTvShowsCalled event,
    Emitter<WatchlistTvShowsState> emit,
  ) async {
    emit(WatchlistTvShowsLoading());

    final result = await _getWatchlistTvShows.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(WatchlistTvShowsEmpty())
            : emit(WatchlistTvShowsHasData(data));
      },
    );
  }

  FutureOr<void> _onWatchlistTvShowStatusCalled(
    OnWatchlistTvShowStatusCalled event,
    Emitter<WatchlistTvShowsState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchListTvStatus.execute(id);

    emit(TvShowIsAddedToWatchlist(result));
  }

  FutureOr<void> _onAddTvShowToWatchlistCalled(
    OnAddTvShowToWatchlistCalled event,
    Emitter<WatchlistTvShowsState> emit,
  ) async {
    final tvShow = event.tvShow;

    final result = await _saveTvWatchlist.execute(tvShow);

    result.fold(
      (failure) {
        emit(WatchlistTvShowsError(failure.message));
      },
      (message) {
        emit(WatchlistTvShowMessage(message));
      },
    );
  }

  FutureOr<void> _onRemoveTvShowWatchlistCalled(
    OnRemoveTvShowWatchlistCalled event,
    Emitter<WatchlistTvShowsState> emit,
  ) async {
    final tvShow = event.tvShow;

    final result = await _removeTvWatchlist.execute(tvShow);

    result.fold(
      (failure) {
        emit(WatchlistTvShowsError(failure.message));
      },
      (message) {
        emit(WatchlistTvShowMessage(message));
      },
    );
  }
}
