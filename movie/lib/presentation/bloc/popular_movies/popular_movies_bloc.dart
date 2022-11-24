import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<OnPopularMoviesCalled>(_onPopularMoviesCalled);
  }

  FutureOr<void> _onPopularMoviesCalled(
    OnPopularMoviesCalled event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(PopularMoviesEmpty())
            : emit(PopularMoviesHasData(data));
      },
    );
  }
}
