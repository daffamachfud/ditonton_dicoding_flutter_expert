import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail _getTvShowDetail;

  TvShowDetailBloc(this._getTvShowDetail) : super(TvShowDetailEmpty()) {
    on<OnTvShowDetailCalled>(_onTvShowDetailCalled);
  }

  FutureOr<void> _onTvShowDetailCalled(OnTvShowDetailCalled event,
      Emitter<TvShowDetailState> emit,) async {
    final id = event.id;
    emit(TvShowDetailLoading());

    final result = await _getTvShowDetail.execute(id);

    result.fold(
          (failure) {
        emit(TvShowDetailError(failure.message));
      },
          (data) {
        emit(TvShowDetailHasData(data));
      },
    );
  }
}
