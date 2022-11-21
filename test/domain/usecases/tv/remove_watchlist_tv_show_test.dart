import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tv/tv_show_dummy_objects.dart';
import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = RemoveTvWatchlist(mockTvShowRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTvShowRepository.removeWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.removeWatchlist(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
