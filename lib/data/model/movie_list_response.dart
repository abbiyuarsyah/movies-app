import 'package:json_annotation/json_annotation.dart';
part 'movie_list_response.g.dart';

@JsonSerializable()
class MovieListResponse {
  int? page;
  @JsonKey(name: "total_pages")
  int? totalPages;
  List<Result>? results;
  @JsonKey(name: "status_message")
  String? statusMesage;
  bool? success;

  MovieListResponse();

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);
}

@JsonSerializable()
class Result {
  int? id;
  String? title;
  String? overview;
  @JsonKey(name: "release_date")
  String? releaseDate;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
