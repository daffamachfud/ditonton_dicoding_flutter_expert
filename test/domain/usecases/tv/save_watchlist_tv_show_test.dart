import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/tv_show_dummy_objects.dart';
import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveTvWatchlist(mockTvShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.saveWatchlist(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
