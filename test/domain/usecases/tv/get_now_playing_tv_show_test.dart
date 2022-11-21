import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvs usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetNowPlayingTvs(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];

  test('should get list of tv show from the repository', () async {
    // arrange
    when(mockTvShowRepository.getNowPlayingTvs())
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShow));
  });
}
