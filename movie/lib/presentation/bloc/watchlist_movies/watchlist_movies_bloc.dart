import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListMoviesStatus _getWatchListMoviesStatus;
  final RemoveMovieWatchlist _removeMovieWatchlist;
  final SaveMovieWatchlist _saveMovieWatchlist;

  WatchlistMoviesBloc(this._getWatchlistMovies, this._getWatchListMoviesStatus,
      this._removeMovieWatchlist, this._saveMovieWatchlist)
      : super(WatchlistMoviesEmpty()) {
    on<OnWatchlistMoviesCalled>(_onWatchlistMoviesCalled);
    on<OnWatchlistMovieStatusCalled>(_onWatchlistMovieStatusCalled);
    on<OnAddMovieToWatchlistCalled>(_onAddMovieToWatchlistCalled);
    on<OnRemoveMovieWatchlistCalled>(_onRemoveMovieWatchlistCalled);
  }

  FutureOr<void> _onWatchlistMoviesCalled(
    OnWatchlistMoviesCalled event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(WatchlistMoviesLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(WatchlistMoviesEmpty())
            : emit(WatchlistMoviesHasData(data));
      },
    );
  }

  FutureOr<void> _onWatchlistMovieStatusCalled(
    OnWatchlistMovieStatusCalled event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchListMoviesStatus.execute(id);

    emit(MovieIsAddedToWatchlist(result));
  }

  FutureOr<void> _onAddMovieToWatchlistCalled(
    OnAddMovieToWatchlistCalled event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final movie = event.movie;

    final result = await _saveMovieWatchlist.execute(movie);

    result.fold(
      (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
      (message) {
        emit(WatchlistMovieMessage(message));
      },
    );
  }

  FutureOr<void> _onRemoveMovieWatchlistCalled(
    OnRemoveMovieWatchlistCalled event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final movie = event.movie;

    final result = await _removeMovieWatchlist.execute(movie);

    result.fold(
      (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
      (message) {
        emit(WatchlistMovieMessage(message));
      },
    );
  }
}
