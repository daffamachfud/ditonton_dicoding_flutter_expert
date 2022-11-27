import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_show_recommendation/tv_show_recommendation_bloc.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late TvShowRecommendationBloc tvShowRecommendationBloc;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;

  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    tvShowRecommendationBloc =
        TvShowRecommendationBloc(mockGetTvShowRecommendations);
  });

  const testId = 1;

  test('the initial state should be empty', () {
    expect(tvShowRecommendationBloc.state, TvShowRecommendationEmpty());
  });

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
    'should emit [Loading, Has Data] when data is gotten successfully',
    build: () {
      when(mockGetTvShowRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvShowRecommendationCalled(testId)),
    expect: () => [
      TvShowRecommendationLoading(),
      TvShowRecommendationHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(testId));
      return OnTvShowRecommendationCalled(testId).props;
    },
  );

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
    'should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTvShowRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvShowRecommendationCalled(testId)),
    expect: () => [
      TvShowRecommendationLoading(),
      TvShowRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TvShowRecommendationLoading(),
  );
}
