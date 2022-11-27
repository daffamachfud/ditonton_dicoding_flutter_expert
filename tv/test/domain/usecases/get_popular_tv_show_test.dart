import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/tv_show_test_helper.mocks.dart';

void main() {
  late GetPopularTvs useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetPopularTvs(mockTvShowRepository);
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
        final result = await useCase.execute();
        // assert
        expect(result, Right(tTvShow));
      });
    });
  });
}
