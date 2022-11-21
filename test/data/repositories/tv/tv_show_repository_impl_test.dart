import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/tv_show_dummy_objects.dart';
import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockTvShowRemoteDataSource;
  late MockTvShowLocalDataSource mockTvShowLocalDataSource;

  setUp(() {
    mockTvShowRemoteDataSource = MockTvShowRemoteDataSource();
    mockTvShowLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockTvShowRemoteDataSource,
      localDataSource: mockTvShowLocalDataSource,
    );
  });

  final tTvShowModel = TvShowModel(
      backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
      firstAirDate: "2021-10-12",
      genreIds: [80, 10765],
      id: 90462,
      name: "Chucky",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 2352.496,
      posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
      voteAverage: 7.9,
      voteCount: 3470);

  final tTvShow = TvShow(
      backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
      firstAirDate: "2021-10-12",
      genreIds: [80, 10765],
      id: 90462,
      name: "Chucky",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 2352.496,
      posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
      voteAverage: 7.9,
      voteCount: 3470);

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Playing Tv Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowPlayingTvs())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockTvShowRemoteDataSource.getNowPlayingTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowPlayingTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockTvShowRemoteDataSource.getNowPlayingTvs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getNowPlayingTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockTvShowRemoteDataSource.getNowPlayingTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Show', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTvs())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getPopularTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getPopularTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Show', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTopRatedTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailResponse(
        adult: false,
        backdropPath: 'backdropPath',
        createdBy: [],
        episodeRunTime: [1],
        firstAirDate: "firstAirDate",
        genres: [
          GenreModel(id: 1, name: "name"),
        ],
        homepage: "homepage",
        id: 1,
        inProduction: false,
        languages: [""],
        lastAirDate: "lastAirDate",
        lastEpisodeToAir: [],
        name: "name",
        nextEpisodeToAir: 1,
        networks: [],
        numberOfEpisodes: 1,
        numberOfSeasons: 1,
        originCountry: [],
        originalLanguage: "originalLanguage",
        originalName: "originalName",
        overview: "overview",
        popularity: 0.0,
        posterPath: "posterPath",
        productionCompanies: [],
        productionCountries: [],
        seasons: [],
        spokenLanguages: [],
        status: "status",
        tagline: "tagline",
        type: "type",
        voteAverage: 0.0,
        voteCount: 1);

    test(
        'should return tv show data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('should return data (tv show list) when the call is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvShowList);
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvShowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assertbuild runner
      verify(mockTvShowRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockTvShowRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Show', () {
    final tQuery = 'House of';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTvs(tQuery))
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTvs(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvShowRemoteDataSource.searchTvs(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist tv', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvShowLocalDataSource.insertTvWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvShowLocalDataSource.insertTvWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv show', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvShowLocalDataSource.removeWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvShowLocalDataSource.removeWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist tv show status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockTvShowLocalDataSource.getTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of tv show', () async {
      // arrange
      when(mockTvShowLocalDataSource.getWatchlistTvs())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getWatchlistTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}
