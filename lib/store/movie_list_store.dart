import 'package:mobx/mobx.dart';
import 'package:movie_db_app/data/constant/store_state.dart';
import 'package:movie_db_app/data/model/movie_list_response.dart';
import 'package:movie_db_app/data/repository/movies_repository.dart';

part 'movie_list_store.g.dart';

class MovieListStore extends _MovieListStore with _$MovieListStore {}

abstract class _MovieListStore with Store {
  MoviesRepository _moviesRepository = MoviesRepository();

  @observable
  ObservableFuture<MovieListResponse>? _movieListResponseFuture;

  @observable
  String? errorMessage;

  @observable
  MovieListResponse? movieListResponse;

  @computed
  StoreState get updateState {
    if (_movieListResponseFuture == null &&
        _movieListResponseFuture?.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _movieListResponseFuture?.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future fetchMovieList(String query, String page) async {
    try {
      _movieListResponseFuture =
          ObservableFuture(_moviesRepository.fetchMovies(query, page));
      movieListResponse = await _movieListResponseFuture;
    } on Exception catch (error) {
      errorMessage = error.toString();
    }
  }
}
