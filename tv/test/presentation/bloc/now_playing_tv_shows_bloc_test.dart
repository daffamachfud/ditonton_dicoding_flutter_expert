import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late NowPlayingTvShowsBloc nowPlayingTvShowsBloc;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    nowPlayingTvShowsBloc = NowPlayingTvShowsBloc(mockGetNowPlayingTvs);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingTvShowsBloc.state, NowPlayingTvShowsEmpty());
  });

  blocTest<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
    'should emit [Loading, Has Data] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvShowsCalled()),
    expect: () => [
      NowPlayingTvShowsLoading(),
      NowPlayingTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvs.execute());
      return OnNowPlayingTvShowsCalled().props;
    },
  );

  blocTest<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
    'should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvShowsCalled()),
    expect: () => [
      NowPlayingTvShowsLoading(),
      NowPlayingTvShowsError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvShowsLoading(),
  );

  blocTest<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
    'should emit [Loading, Empty] when data is gotten empty',
    build: () {
      when(mockGetNowPlayingTvs.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvShowsCalled()),
    expect: () => [
      NowPlayingTvShowsLoading(),
      NowPlayingTvShowsEmpty(),
    ],
  );
}
