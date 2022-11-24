import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_shows/search_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'search_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late MockSearchTvs mockSearchTvShow;
  late SearchTvShowsBloc searchTvShowsBloc;

  const testId = 1;
}
