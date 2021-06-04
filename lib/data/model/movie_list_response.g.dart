// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) {
  return MovieListResponse()
    ..page = json['page'] as int?
    ..totalPages = json['total_pages'] as int?
    ..results = (json['results'] as List<dynamic>?)
        ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
        .toList()
    ..statusMesage = json['status_message'] as String?
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'results': instance.results,
      'status_message': instance.statusMesage,
      'success': instance.success,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result()
    ..id = json['id'] as int?
    ..title = json['title'] as String?
    ..overview = json['overview'] as String?
    ..releaseDate = json['release_date'] as String?;
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
    };
