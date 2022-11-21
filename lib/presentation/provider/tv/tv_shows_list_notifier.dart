import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:flutter/material.dart';

class TvShowsListNotifier extends ChangeNotifier {
  var _nowPlayingTvSeries = <TvShow>[];

  List<TvShow> get nowPlayingTvSeries => _nowPlayingTvSeries;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvSeries = <TvShow>[];

  List<TvShow> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;

  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TvShow>[];

  List<TvShow> get topRatedTvShow => _topRatedTvSeries;

  RequestState _topRatedTvShowState = RequestState.Empty;

  RequestState get topRatedTvShowState => _topRatedTvShowState;

  String _message = '';

  String get message => _message;

  TvShowsListNotifier({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTVs,
  });

  final GetNowPlayingTvs getNowPlayingTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTVs;

  Future<void> fetchNowPlayingTvs() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvs.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvSeries = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvSeriesState = RequestState.Loaded;
        _popularTvSeries = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVs.execute();
    result.fold(
      (failure) {
        _topRatedTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvShowState = RequestState.Loaded;
        _topRatedTvSeries = tvsData;
        notifyListeners();
      },
    );
  }
}
