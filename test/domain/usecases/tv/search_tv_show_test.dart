import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_show.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv/tv_show_test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvs(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];
  final tQuery = 'House of';

  test('should get list of tv show from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvs(tQuery))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShow));
  });
}
