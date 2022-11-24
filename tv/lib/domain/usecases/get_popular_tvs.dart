import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetPopularTvs {
  final TvShowRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvs();
  }
}
