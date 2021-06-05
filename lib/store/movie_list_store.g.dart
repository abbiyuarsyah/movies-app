// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieListStore on _MovieListStore, Store {
  Computed<StoreState>? _$updateStateComputed;

  @override
  StoreState get updateState =>
      (_$updateStateComputed ??= Computed<StoreState>(() => super.updateState,
              name: '_MovieListStore.updateState'))
          .value;

  final _$_movieListResponseFutureAtom =
      Atom(name: '_MovieListStore._movieListResponseFuture');

  @override
  ObservableFuture<MovieListResponse>? get _movieListResponseFuture {
    _$_movieListResponseFutureAtom.reportRead();
    return super._movieListResponseFuture;
  }

  @override
  set _movieListResponseFuture(ObservableFuture<MovieListResponse>? value) {
    _$_movieListResponseFutureAtom
        .reportWrite(value, super._movieListResponseFuture, () {
      super._movieListResponseFuture = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_MovieListStore.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$movieListResponseAtom =
      Atom(name: '_MovieListStore.movieListResponse');

  @override
  MovieListResponse? get movieListResponse {
    _$movieListResponseAtom.reportRead();
    return super.movieListResponse;
  }

  @override
  set movieListResponse(MovieListResponse? value) {
    _$movieListResponseAtom.reportWrite(value, super.movieListResponse, () {
      super.movieListResponse = value;
    });
  }

  final _$fetchMovieListAsyncAction =
      AsyncAction('_MovieListStore.fetchMovieList');

  @override
  Future<dynamic> fetchMovieList(String query, String page) {
    return _$fetchMovieListAsyncAction
        .run(() => super.fetchMovieList(query, page));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
movieListResponse: ${movieListResponse},
updateState: ${updateState}
    ''';
  }
}
