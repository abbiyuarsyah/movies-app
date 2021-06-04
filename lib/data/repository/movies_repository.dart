import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_db_app/data/model/movie_list_response.dart';
import 'package:movie_db_app/data/service/base_api.dart';

class MoviesRepository {
  Future<MovieListResponse> fetchMovies() async {
    final movieListResponse = MovieListResponse();

    try {
      Response response =
          await baseApi.getDio().post(BaseApi.baseUrl + 'search/movie');
      return MovieListResponse.fromJson(json.decode(response.data));
    } on DioError catch (error) {
      movieListResponse.statusMesage = baseApi.catchErrorNetwork(error);
      return movieListResponse;
    }
  }
}
