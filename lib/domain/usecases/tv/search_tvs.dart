import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class SearchTvs {
  final TvShowRepository repository;

  SearchTvs(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvs(query);
  }
}
