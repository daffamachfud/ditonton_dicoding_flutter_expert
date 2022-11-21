import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/tv/tv_shows_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_show_notifier_test.mocks.dart';
import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs, GetPopularMovies, GetTopRatedTvs])
void main() {
  late TvShowsListNotifier provider;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    provider = TvShowsListNotifier(
      getNowPlayingTvs: mockGetNowPlayingTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTVs: mockGetTopRatedTvs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShow = TvShow(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1],
      id: 1,
      name: "name",
      originCountry: ["originCountry"],
      originalLanguage: "en",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  final tTvShowList = <TvShow>[tTvShow];

  group('now playing tv show', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchNowPlayingTvs();
      // assert
      verify(mockGetNowPlayingTvs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchNowPlayingTvs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchNowPlayingTvs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvSeries, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvs();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv show data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loaded);
      expect(provider.topRatedTvShow, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
