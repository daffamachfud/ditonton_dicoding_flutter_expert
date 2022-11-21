import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetPopularTvs(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];

  group('GetPopularTvShow Tests', () {
    group('execute', () {
      test(
          'should get list of tv show from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvShowRepository.getPopularTvs())
            .thenAnswer((_) async => Right(tTvShow));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShow));
      });
    });
  });
}
