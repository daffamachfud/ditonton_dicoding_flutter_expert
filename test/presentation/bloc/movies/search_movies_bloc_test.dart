import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:mockito/annotations.dart';

import 'search_movies_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesBloc searchMoviesBloc;

  const testId = 1;
}
