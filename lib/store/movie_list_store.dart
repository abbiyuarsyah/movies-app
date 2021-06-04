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
  Future fetchMovies() async {
    try {
      final movieResponse = await _moviesRepository.fetchMovies();
      if ((movieResponse.results?.length ?? 0) > 0) {
        _movieListResponseFuture =
            ObservableFuture(Future.value(movieResponse));
      } else {
        errorMessage = movieResponse.statusMesage ?? "Something is wrong";
      }
    } on Exception catch (error) {
      errorMessage = error.toString();
    }
  }
}
