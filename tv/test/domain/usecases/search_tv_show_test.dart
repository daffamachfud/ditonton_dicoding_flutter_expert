import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import '../../helpers/tv_show_test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvs(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];
  const tQuery = 'House of';

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
