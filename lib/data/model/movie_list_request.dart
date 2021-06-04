import 'package:json_annotation/json_annotation.dart';
import 'package:movie_db_app/data/service/api_config.dart';
part 'movie_list_request.g.dart';

@JsonSerializable()
class MovieListRequest {
  String? query;
  String? page;
  @JsonKey(name: "api_key")
  String? apiKey = ApiConfig.apiKey;

  MovieListRequest(this.query, this.page);

  Map<String, dynamic> toJson() => _$MovieListRequestToJson(this);
}
