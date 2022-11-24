import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/tv/search_tvs.dart';
import 'package:search/presentation/bloc/search_tv_shows/search_tv_shows_event.dart';
import 'package:search/presentation/bloc/search_tv_shows/search_tv_shows_state.dart';

class SearchTvShowsBloc extends Bloc<SearchTvShowsEvent, SearchTvShowsState> {
  final SearchTvs _searchTvShows;

  SearchTvShowsBloc(this._searchTvShows) : super(SearchTvShowsEmpty()) {
    on<OnQueryTvShowChanged>(_onQueryTvShowChanged);
  }

  FutureOr<void> _onQueryTvShowChanged(
    OnQueryTvShowChanged event,
    Emitter<SearchTvShowsState> emit,
  ) async {
    final query = event.query;
    emit(SearchTvShowsLoading());

    final result = await _searchTvShows.execute(query);

    result.fold(
      (failure) {
        emit(SearchTvShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(SearchTvShowsEmpty())
            : emit(SearchTvShowsHasData(data));
      },
    );
  }
}
