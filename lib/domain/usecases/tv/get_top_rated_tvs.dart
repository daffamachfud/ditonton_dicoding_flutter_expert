import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTopRatedTvs {
  final TvShowRepository repository;

  GetTopRatedTvs(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvs();
  }
}
