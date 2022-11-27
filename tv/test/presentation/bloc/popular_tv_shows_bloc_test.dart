import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetPopularTvs mockGetPopularTvs;
  late PopularTvShowsBloc popularTvShowsBloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvShowsBloc = PopularTvShowsBloc(mockGetPopularTvs);
  });

  test('the initial state should be empty', () {
    expect(popularTvShowsBloc.state, PopularTvShowsEmpty());
  });

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'should emit [Loading, Has Data] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvShowsCalled()),
    expect: () => [
      PopularTvShowsLoading(),
      PopularTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
      return OnPopularTvShowsCalled().props;
    },
  );

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvShowsCalled()),
    expect: () => [
      PopularTvShowsLoading(),
      PopularTvShowsError('Server Failure'),
    ],
    verify: (bloc) => PopularTvShowsLoading(),
  );

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'should emit [Loading, Empty] when data is gotten empty',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvShowsCalled()),
    expect: () => [
      PopularTvShowsLoading(),
      PopularTvShowsEmpty(),
    ],
  );
}
