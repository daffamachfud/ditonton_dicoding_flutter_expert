import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchListTvStatus {
  final TvShowRepository repository;

  GetWatchListTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
