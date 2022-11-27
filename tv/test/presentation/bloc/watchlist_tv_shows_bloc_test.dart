import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late WatchlistTvShowsBloc watchlistTvShowsBloc;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    watchlistTvShowsBloc = WatchlistTvShowsBloc(mockGetWatchlistTvs,
        mockGetWatchListTvStatus, mockRemoveTvWatchlist, mockSaveTvWatchlist);
  });

  test('the initial state should be empty', () {
    expect(watchlistTvShowsBloc.state, WatchlistTvShowsEmpty());
  });

  group('Get Watchlist', () {
    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should emit [Loading, Has Data] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(testTvShowList));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvShowsCalled()),
      expect: () => [
        WatchlistTvShowsLoading(),
        WatchlistTvShowsHasData(testTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
        return OnWatchlistTvShowsCalled().props;
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should emit [Loading, Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvShowsCalled()),
      expect: () => [
        WatchlistTvShowsLoading(),
        WatchlistTvShowsError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvShowsLoading(),
    );

    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should emit [Loading, Empty] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvShowsCalled()),
      expect: () => [
        WatchlistTvShowsLoading(),
        WatchlistTvShowsEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
        return OnWatchlistTvShowsCalled().props;
      },
    );
  });

  group('Watchlist Status', () {
    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should return true when tv show is added to watchlist',
      build: () {
        when(mockGetWatchListTvStatus.execute(testTvShowDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvShowsBloc;
      },
      act: (bloc) =>
          bloc.add(OnWatchlistTvShowStatusCalled(testTvShowDetail.id)),
      expect: () => [TvShowIsAddedToWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListTvStatus.execute(testTvShowDetail.id));
        return OnWatchlistTvShowStatusCalled(testTvShowDetail.id).props;
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should return false when tv show is not added to watchlist',
      build: () {
        when(mockGetWatchListTvStatus.execute(testTvShowDetail.id))
            .thenAnswer((_) async => false);
        return watchlistTvShowsBloc;
      },
      act: (bloc) =>
          bloc.add(OnWatchlistTvShowStatusCalled(testTvShowDetail.id)),
      expect: () => [TvShowIsAddedToWatchlist(false)],
      verify: (bloc) {
        verify(mockGetWatchListTvStatus.execute(testTvShowDetail.id));
        return OnWatchlistTvShowStatusCalled(testTvShowDetail.id).props;
      },
    );
  });

  group('Watchlist Save and Remove', () {
    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should update watchlist when tv show adding to watchlist',
      build: () {
        when(mockSaveTvWatchlist.execute(testTvShowDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnAddTvShowToWatchlistCalled(testTvShowDetail)),
      expect: () => [WatchlistTvShowMessage(watchlistAddSuccessMessage)],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(testTvShowDetail));
        return OnAddTvShowToWatchlistCalled(testTvShowDetail).props;
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should throw error message  when tv show adding to watchlist failed',
      build: () {
        when(mockSaveTvWatchlist.execute(testTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnAddTvShowToWatchlistCalled(testTvShowDetail)),
      expect: () => [WatchlistTvShowsError('Error')],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(testTvShowDetail));
        return OnAddTvShowToWatchlistCalled(testTvShowDetail).props;
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should update watchlist when tv show removing to watchlist',
      build: () {
        when(mockRemoveTvWatchlist.execute(testTvShowDetail)).thenAnswer(
            (_) async => const Right(watchlistRemoveSuccessMessage));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnRemoveTvShowWatchlistCalled(testTvShowDetail)),
      expect: () => [WatchlistTvShowMessage(watchlistRemoveSuccessMessage)],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(testTvShowDetail));
        return OnRemoveTvShowWatchlistCalled(testTvShowDetail).props;
      },
    );

    blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      'should throw error message  when tv show removing to watchlist failed',
      build: () {
        when(mockRemoveTvWatchlist.execute(testTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Error')));
        return watchlistTvShowsBloc;
      },
      act: (bloc) => bloc.add(OnRemoveTvShowWatchlistCalled(testTvShowDetail)),
      expect: () => [WatchlistTvShowsError('Error')],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(testTvShowDetail));
        return OnRemoveTvShowWatchlistCalled(testTvShowDetail).props;
      },
    );
  });
}
