import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

import '../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
      backdropPath: "backdropPath",
      firstAirDate: "2022-10-29",
      genreIds: const [1, 2, 3, 4],
      id: 1,
      name: "name",
      originCountry: const ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  final tTvShowResponseModel =
      TvShowResponse(tvList: <TvShowModel>[tTvShowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "backdropPath",
            "first_air_date": "2022-10-29",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
             "name" : 'name',
            "origin_country": ['originCountry'],
            "original_language" : 'originalLanguage',
            'original_name': 'originalName',
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "posterPath",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
