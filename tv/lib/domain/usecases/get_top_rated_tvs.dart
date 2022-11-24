import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTopRatedTvs {
  final TvShowRepository repository;

  GetTopRatedTvs(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvs();
  }
}
