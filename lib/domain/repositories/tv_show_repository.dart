import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/entities/tv/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvs();

  Future<Either<Failure, List<TvShow>>> getPopularTvs();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvs();

  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTvs(String query);

  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow);

  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvs();
}
