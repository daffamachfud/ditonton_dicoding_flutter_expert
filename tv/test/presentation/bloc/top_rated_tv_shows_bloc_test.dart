import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TopRatedTvShowsBloc topRatedTvShowsBloc;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvShowsBloc = TopRatedTvShowsBloc(mockGetTopRatedTvs);
  });

  test('the initial state should be empty', () {
    expect(topRatedTvShowsBloc.state, TopRatedTvShowsEmpty());
  });

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'should emit [Loading, Has Data] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return topRatedTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvShowsCalled()),
    expect: () => [
      TopRatedTvShowsLoading(),
      TopRatedTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
      return OnTopRatedTvShowsCalled().props;
    },
  );

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'should emit [Loading, Error] when data is gotten unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvShowsCalled()),
    expect: () => [
      TopRatedTvShowsLoading(),
      TopRatedTvShowsError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvShowsLoading(),
  );
}
