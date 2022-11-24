import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockUseCase;
  late MovieRecom movieDetailBloc;

  const testId = 1;
}