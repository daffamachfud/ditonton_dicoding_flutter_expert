import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

void main() {
  final testTable = TvShowTable(
    id: 1,
    name: 'name',
    posterPath: 'path',
    overview: 'overview',
  );
  final testEntity = TvShow.watchlist(
    id: 1,
    name: 'name',
    posterPath: 'path',
    overview: 'overview',
  );

  final testTvShowDetail = TvShowDetail(
      adult: false,
      backdropPath: 'backdropPath',
      createdBy: const [],
      episodeRunTime: const [1],
      firstAirDate: "firstAirDate",
      genres: [
        GenreModel(id: 1, name: "name"),
      ],
      homepage: "homepage",
      id: 1,
      inProduction: false,
      languages: const [""],
      lastAirDate: "lastAirDate",
      lastEpisodeToAir: const [],
      name: "name",
      nextEpisodeToAir: 1,
      networks: const [],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: const [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 0.0,
      posterPath: "path",
      productionCompanies: const [],
      productionCountries: const [],
      seasons: const [],
      spokenLanguages: const [],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 0.0,
      voteCount: 1);

  final testJsonMap = {
    'id': 1,
    'name': 'name',
    'posterPath': 'path',
    'overview': 'overview',
  };

  test('should return valid table from model', () {
    //arrange
    //act
    final result = testTable;
    //assert
    expect(result, testTable);
  });
  test('should return valid table from json', () {
    //arrange
    //act
    final result = TvShowTable.fromMap(testJsonMap);
    //assert
    expect(result, testTable);
  });
  test('should return valid table from entity', () {
    //arrange
    //act
    final result = TvShowTable.fromEntity(testTvShowDetail);
    //assert
    expect(result, testTable);
  });
  test('should return valid entity from table', () {
    //arrange
    //act
    final result = testTable.toEntity();
    //assert
    expect(result, testEntity);
  });
  test('should return valid jsonMap from table', () {
    //arrange
    //act
    final result = testTable.toJson();
    //assert
    expect(result, testJsonMap);
  });
}
