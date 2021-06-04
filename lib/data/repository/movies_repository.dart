import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_db_app/data/model/movie_list_request.dart';
import 'package:movie_db_app/data/model/movie_list_response.dart';
import 'package:movie_db_app/data/service/base_api.dart';

class MoviesRepository {
  Future<MovieListResponse> fetchMovies(String query, String page) async {
    final movieListResponse = MovieListResponse();
    final request = MovieListRequest(query, page);

    try {
      Response response = await baseApi.getDio().get(
          (BaseApi.baseUrl + 'search/movie'),
          queryParameters: request.toJson());
      return MovieListResponse.fromJson(json.decode(response.data));
    } on DioError catch (error) {
      movieListResponse.statusMesage = baseApi.catchErrorNetwork(error);
      return movieListResponse;
    }
  }
}
