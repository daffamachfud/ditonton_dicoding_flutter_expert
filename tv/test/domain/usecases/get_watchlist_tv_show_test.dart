import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/tv_show_test_helper.mocks.dart';

void main() {
  late GetWatchlistTvs usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetWatchlistTvs(mockTvShowRepository);
  });

  test('should get list of tv show from the repository', () async {
    // arrange
    when(mockTvShowRepository.getWatchlistTvs())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}
