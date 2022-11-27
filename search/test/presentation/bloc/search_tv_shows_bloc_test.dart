import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockSearchTvs mockSearchTvs;
  late SearchTvShowsBloc searchTvShowsBloc;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvShowsBloc = SearchTvShowsBloc(mockSearchTvs);
  });

  test('initial state shoud be empty', () {
    expect(searchTvShowsBloc.state, SearchTvShowsEmpty());
  });

  final tTvShowModel = TvShow(
      backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
      firstAirDate: "2021-10-12",
      genreIds: const [80, 10765],
      id: 90462,
      name: "Chucky",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "Chucky",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
      popularity: 2352.496,
      posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
      voteAverage: 7.9,
      voteCount: 3470);
  final tTvShowList = <TvShow>[tTvShowModel];
  const tQuery = 'Chucky';

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      return searchTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchTvShowsLoading(),
      SearchTvShowsHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'should emit [Loading, Error] when the searched data failed to fetch',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchTvShowsLoading(),
      SearchTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
      return SearchTvShowsLoading().props;
    },
  );
}
