import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:dartz/dartz.dart';

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
