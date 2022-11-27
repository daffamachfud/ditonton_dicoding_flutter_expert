import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

void main() {
  final testTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'path',
    overview: 'overview',
  );
  final testEntity = Movie.watchlist(
    id: 1,
    title: 'title',
    posterPath: 'path',
    overview: 'overview',
  );

  final testMovieDetail = MovieDetail(
    genres: [Genre(id: 1, name: '2')],
    id: 1,
    backdropPath: null,
    overview: 'overview',
    posterPath: 'path',
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    originalTitle: '',
    releaseDate: '',
    runtime: 80,
    title: 'title',
  );
  final testJsonMap = {
    'id': 1,
    'title': 'title',
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
    final result = MovieTable.fromMap(testJsonMap);
    //assert
    expect(result, testTable);
  });
  test('should return valid table from entity', () {
    //arrange
    //act
    final result = MovieTable.fromEntity(testMovieDetail);
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
