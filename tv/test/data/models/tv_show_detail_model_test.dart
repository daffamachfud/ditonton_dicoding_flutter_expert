import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_show_detail_model.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

main() {
  final testTvShowResponse = TvShowDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    type: 'type',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    seasons: const ['1'],
    episodeRunTime: const [1],
    firstAirDate: 'firstAirDate',
    genres: const [],
    id: 1,
    overview: 'overview',
    voteCount: 1,
    tagline: 'tagline',
    originalName: 'originalName',
    homepage: 'homepage',
    voteAverage: 1,
    originalLanguage: 'originalLanguage',
    status: 'status',
    createdBy: const ['createdBy'],
    inProduction: false,
    languages: const ['US'],
    lastAirDate: '',
    lastEpisodeToAir: const [''],
    nextEpisodeToAir: const [''],
    networks: const ['US'],
    originCountry: const ['US'],
    productionCompanies: const ['Es'],
    productionCountries: const ["US"],
    spokenLanguages: const ['US'],
  );

  final testTvShowDetail = testTvShowResponse.toEntity();

  test('should be a subclass of Tv Show Detail entity', () async {
    final result = testTvShowResponse.toEntity();
    expect(result, testTvShowDetail);
  });

  test('should be a map of tv show', () async {
    final result = testTvShowMap;
    expect(result, testTvShowMap);
  });

}
