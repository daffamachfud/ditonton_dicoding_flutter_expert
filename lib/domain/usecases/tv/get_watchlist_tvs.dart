import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchlistTvs {
  final TvShowRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getWatchlistTvs();
  }
}
