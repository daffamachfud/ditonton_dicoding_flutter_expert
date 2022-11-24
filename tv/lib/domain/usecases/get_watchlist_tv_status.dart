import 'package:tv/tv.dart';

class GetWatchListTvStatus {
  final TvShowRepository repository;

  GetWatchListTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
