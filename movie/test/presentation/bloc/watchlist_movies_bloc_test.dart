import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListMoviesStatus mockGetWatchListMoviesStatus;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late WatchlistMoviesBloc watchlistMoviesBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListMoviesStatus = MockGetWatchListMoviesStatus();
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    watchlistMoviesBloc = WatchlistMoviesBloc(
        mockGetWatchlistMovies,
        mockGetWatchListMoviesStatus,
        mockRemoveMovieWatchlist,
        mockSaveMovieWatchlist);
  });

  test('the initial state should be empty', () {
    expect(watchlistMoviesBloc.state, WatchlistMoviesEmpty());
  });

  group('Get Watchlist', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Has Data] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesCalled()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return OnWatchlistMoviesCalled().props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesCalled()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMoviesLoading(),
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Empty] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesCalled()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return OnWatchlistMoviesCalled().props;
      },
    );
  });

  group('Watchlist Status', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should return true when movie is added to watchlist',
      build: () {
        when(mockGetWatchListMoviesStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovieStatusCalled(testMovieDetail.id)),
      expect: () => [MovieIsAddedToWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListMoviesStatus.execute(testMovieDetail.id));
        return OnWatchlistMovieStatusCalled(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should return false when movie is not added to watchlist',
      build: () {
        when(mockGetWatchListMoviesStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovieStatusCalled(testMovieDetail.id)),
      expect: () => [MovieIsAddedToWatchlist(false)],
      verify: (bloc) {
        verify(mockGetWatchListMoviesStatus.execute(testMovieDetail.id));
        return OnWatchlistMovieStatusCalled(testMovieDetail.id).props;
      },
    );
  });

  group('Watchlist Save and Remove', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should update watchlist when movie adding to watchlist',
      build: () {
        when(mockSaveMovieWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnAddMovieToWatchlistCalled(testMovieDetail)),
      expect: () => [WatchlistMovieMessage(watchlistAddSuccessMessage)],
      verify: (bloc) {
        verify(mockSaveMovieWatchlist.execute(testMovieDetail));
        return OnAddMovieToWatchlistCalled(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should throw error message  when movie adding to watchlist failed',
      build: () {
        when(mockSaveMovieWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnAddMovieToWatchlistCalled(testMovieDetail)),
      expect: () => [WatchlistMoviesError('Error')],
      verify: (bloc) {
        verify(mockSaveMovieWatchlist.execute(testMovieDetail));
        return OnAddMovieToWatchlistCalled(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should update watchlist when movie removing to watchlist',
      build: () {
        when(mockRemoveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right(watchlistRemoveSuccessMessage));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRemoveMovieWatchlistCalled(testMovieDetail)),
      expect: () => [WatchlistMovieMessage(watchlistRemoveSuccessMessage)],
      verify: (bloc) {
        verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
        return OnRemoveMovieWatchlistCalled(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should throw error message  when movie removing to watchlist failed',
      build: () {
        when(mockRemoveMovieWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRemoveMovieWatchlistCalled(testMovieDetail)),
      expect: () => [WatchlistMoviesError('Error')],
      verify: (bloc) {
        verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
        return OnRemoveMovieWatchlistCalled(testMovieDetail).props;
      },
    );
  });
}
