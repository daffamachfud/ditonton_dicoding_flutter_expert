import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<OnTopRatedMoviesCalled>(_onTopRatedMoviesCalled);
  }

  FutureOr<void> _onTopRatedMoviesCalled(
    OnTopRatedMoviesCalled event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(TopRatedMoviesLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TopRatedMoviesEmpty())
            : emit(TopRatedMoviesHasData(data));
      },
    );
  }
}
