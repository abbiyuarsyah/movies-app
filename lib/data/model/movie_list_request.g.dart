// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListRequest _$MovieListRequestFromJson(Map<String, dynamic> json) {
  return MovieListRequest(
    json['query'] as String?,
    json['page'] as String?,
  )..apiKey = json['api_key'] as String?;
}

Map<String, dynamic> _$MovieListRequestToJson(MovieListRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'page': instance.page,
      'api_key': instance.apiKey,
    };
