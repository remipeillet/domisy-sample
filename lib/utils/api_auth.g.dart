// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiAuthManagerRestClient implements ApiAuthManagerRestClient {
  _ApiAuthManagerRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://51.68.230.193/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<_ApiAuthManager> getToken(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/authenticate/token/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _ApiAuthManager.fromJson(_result.data);
    return value;
  }

  @override
  Future<_ApiAuthManager> refreshToken(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/authenticate/token/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _ApiAuthManager.fromJson(_result.data);
    return value;
  }
}
