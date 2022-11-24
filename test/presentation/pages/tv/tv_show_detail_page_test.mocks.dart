// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/tv/tv_show_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i6;
import 'package:ditonton/presentation/bloc/tv/tv_show_detail/tv_show_detail_bloc.dart'
    as _i3;
import 'package:ditonton/presentation/bloc/tv/tv_show_detail/tv_show_detail_event.dart'
    as _i5;
import 'package:ditonton/presentation/bloc/tv/tv_show_detail/tv_show_detail_state.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeTvShowDetailState_0 extends _i1.SmartFake
    implements _i2.TvShowDetailState {
  _FakeTvShowDetailState_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvShowDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowDetailBloc extends _i1.Mock implements _i3.TvShowDetailBloc {
  MockTvShowDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowDetailState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue:
                  _FakeTvShowDetailState_0(this, Invocation.getter(#state)))
          as _i2.TvShowDetailState);
  @override
  _i4.Stream<_i2.TvShowDetailState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: _i4.Stream<_i2.TvShowDetailState>.empty())
          as _i4.Stream<_i2.TvShowDetailState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.TvShowDetailEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.TvShowDetailEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.TvShowDetailState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.TvShowDetailEvent>(
          _i6.EventHandler<E, _i2.TvShowDetailState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i5.TvShowDetailEvent, _i2.TvShowDetailState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i6.Change<_i2.TvShowDetailState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
