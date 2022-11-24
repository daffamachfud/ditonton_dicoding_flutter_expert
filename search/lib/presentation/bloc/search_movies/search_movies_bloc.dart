import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/movie/search_movies.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_event.dart';
import 'package:search/presentation/bloc/search_movies/search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesEmpty()) {
    on<OnQueryMovieChanged>(_onQueryMovieChanged);
  }

  FutureOr<void> _onQueryMovieChanged(
    OnQueryMovieChanged event,
    Emitter<SearchMoviesState> emit,
  ) async {
    final query = event.query;
    emit(SearchMoviesLoading());

    final result = await _searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(SearchMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(SearchMoviesEmpty())
            : emit(SearchMoviesHasData(data));
      },
    );
  }
}
