import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/provider/tv/now_playing_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late NowPlayingTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    notifier = NowPlayingTvNotifier(mockGetNowPlayingTvs)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv show data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    await notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
