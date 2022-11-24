import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_shows/watchlist_tv_shows_bloc.dart';
import 'package:mockito/annotations.dart';

import 'watchlist_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late WatchlistTvShowsBloc watchlistTvShowsBloc;

  const testId = 1;
}
