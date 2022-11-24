import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class SaveTvWatchlist {
  final TvShowRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShowDetail) {
    return repository.saveWatchlist(tvShowDetail);
  }
}
