import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/exception.dart';
import 'package:tv/tv.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertTvWatchlist(TvShowTable tvShow);

  Future<String> removeWatchlist(TvShowTable tvShow);

  Future<TvShowTable?> getTvById(int id);

  Future<List<TvShowTable>> getWatchlistTvs();
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTvWatchlist(TvShowTable tvShow) async {
    try {
      await databaseHelper.insertTvShowWatchlist(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeTvWatchlist(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvById(int id) async {
    final result = await databaseHelper.getWatchlistTvById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvs() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }
}
