import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchlistMovies,
  GetWatchListMoviesStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist,
])
void main() {}
