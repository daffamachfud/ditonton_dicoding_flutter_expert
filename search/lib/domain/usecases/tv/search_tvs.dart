import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class SearchTvs {
  final TvShowRepository repository;

  SearchTvs(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvs(query);
  }
}
