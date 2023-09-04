import 'package:the_moviedb/config/configuration.dart';
import 'package:the_moviedb/domain/api_client/network_client.dart';

enum MediaType {
  movie,
  tv,
}

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['id'] as int;
      return response;
    }

    final result = _networkClient.get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<String> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['status_message'] as String;
      return response;
    }

    final urlParametrs = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };
    final result = _networkClient.post(
      '/account/$accountId/favorite',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
      urlParametrs,
    );
    return result;
  }
}
