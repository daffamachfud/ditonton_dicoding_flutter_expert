import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/tv_show_test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowRecommendations(mockTvShowRepository);
  });

  const tId = 1;
  final tTvShow = <TvShow>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTvShowRepository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(tTvShow));
  });
}
