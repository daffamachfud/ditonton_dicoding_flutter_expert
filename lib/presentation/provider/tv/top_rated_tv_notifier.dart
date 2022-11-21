import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvNotifier({required this.getTopRatedTvs});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _tvShow = [];

  List<TvShow> get tvShows => _tvShow;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tvShow = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}