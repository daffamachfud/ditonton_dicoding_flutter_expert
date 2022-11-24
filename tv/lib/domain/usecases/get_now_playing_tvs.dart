import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetNowPlayingTvs {
  final TvShowRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
