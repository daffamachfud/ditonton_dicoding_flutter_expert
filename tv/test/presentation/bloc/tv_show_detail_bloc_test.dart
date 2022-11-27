import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';


void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late MockGetTvShowDetail mockGetTvShowDetail;

  const testId = 1;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(mockGetTvShowDetail);
  });

  test('should empty when initial state', () {
    expect(tvShowDetailBloc.state, TvShowDetailEmpty());
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'should emit [Loading, Has Data] when data is gotten successfully',
    build: () {
      when(mockGetTvShowDetail.execute(testId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvShowDetailCalled(testId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailHasData(testTvShowDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(testId));
      return OnTvShowDetailCalled(testId).props;
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvShowDetailCalled(testId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailError('Server Failure'),
    ],
    verify: (bloc) => TvShowDetailLoading(),
  );
}
