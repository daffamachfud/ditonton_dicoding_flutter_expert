import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<OnNowPlayingMoviesCalled>(_onNowPlayingMoviesCalled);
  }

  FutureOr<void> _onNowPlayingMoviesCalled(
    OnNowPlayingMoviesCalled event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    emit(NowPlayingMoviesLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(NowPlayingMoviesEmpty())
            : emit(NowPlayingMoviesHasData(data));
      },
    );
  }
}
