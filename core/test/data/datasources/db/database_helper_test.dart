import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie_dummy_objects.dart';
import '../../../dummy_data/tv_show_dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final testMovieTableId = testMovieTable.id;
  final testTvShowTableId = testTvShowTable.id;

  group('Movie test on db', () {
    test('should return movie id when insert new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result =
          await mockDatabaseHelper.insertMovieWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie id when delete a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result =
          await mockDatabaseHelper.removeMovieWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return list of movie map when get watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistMovies();
      // assert
      expect(result, [testMovieMap]);
    });
  });

  group('Tv Show test on db', () {
    test('should return tv show id when insert new tv show', () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => testTvShowTableId);
      // act
      final result =
          await mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable);
      // assert
      expect(result, testTvShowTableId);
    });

    test('should return tv show id when delete a tv show', () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvShowTable))
          .thenAnswer((_) async => testTvShowTableId);
      // act
      final result =
          await mockDatabaseHelper.removeTvWatchlist(testTvShowTable);
      // assert
      expect(result, testTvShowTableId);
    });

    test('should return list of tv show map when get watchlist tv shows',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistTvShows();
      // assert
      expect(result, [testTvShowMap]);
    });
  });
}
