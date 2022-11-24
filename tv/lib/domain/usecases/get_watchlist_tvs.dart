import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetWatchlistTvs {
  final TvShowRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getWatchlistTvs();
  }
}
