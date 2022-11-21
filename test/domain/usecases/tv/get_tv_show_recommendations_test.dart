import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowRecommendations(mockTvShowRepository);
  });

  final tId = 1;
  final tTvShow = <TvShow>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTvShowRepository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvShow));
  });
}
