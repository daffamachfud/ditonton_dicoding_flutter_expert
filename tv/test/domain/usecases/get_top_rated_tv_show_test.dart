import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/tv_show_test_helper.mocks.dart';

void main() {
  late GetTopRatedTvs useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTopRatedTvs(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];

  test('should get list of tv show from repository', () async {
    // arrange
    when(mockTvShowRepository.getTopRatedTvs())
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tTvShow));
  });
}
