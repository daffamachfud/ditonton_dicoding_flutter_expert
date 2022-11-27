// Mocks generated by Mockito 5.3.2 from annotations
// in search/test/helpers/bloc_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/movie.dart' as _i4;
import 'package:search/domain/usecases/movie/search_movies.dart' as _i8;
import 'package:search/domain/usecases/tv/search_tvs.dart' as _i5;
import 'package:tv/tv.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvShowRepository_0 extends _i1.SmartFake
    implements _i2.TvShowRepository {
  _FakeTvShowRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieRepository_2 extends _i1.SmartFake
    implements _i4.MovieRepository {
  _FakeMovieRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchTvs].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTvs extends _i1.Mock implements _i5.SearchTvs {
  MockSearchTvs() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvShowRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvShowRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i2.TvShow>>> execute(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [query],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i2.TvShow>>>.value(
                _FakeEither_1<_i7.Failure, List<_i2.TvShow>>(
          this,
          Invocation.method(
            #execute,
            [query],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i2.TvShow>>>);
}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends _i1.Mock implements _i8.SearchMovies {
  MockSearchMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMovieRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.MovieRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i4.Movie>>> execute(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [query],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, List<_i4.Movie>>>.value(
            _FakeEither_1<_i7.Failure, List<_i4.Movie>>(
          this,
          Invocation.method(
            #execute,
            [query],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i4.Movie>>>);
}
