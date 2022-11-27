import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

class SearchMoviesEventFake extends Fake implements SearchMoviesEvent {}

class SearchMoviesStateFake extends Fake implements SearchMoviesState {}

class MockSearchMoviesBloc
    extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}
