import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_auth.g.dart';

@RestApi(baseUrl: DomisyDio.apiBaseUrl)
abstract class ApiAuthManagerRestClient {
  factory ApiAuthManagerRestClient(Dio dio, {String baseUrl}) =
      _ApiAuthManagerRestClient;
  @POST("/authenticate/token/")
  @FormUrlEncoded()
  Future<_ApiAuthManager> getToken(
    @Body() Map<String, dynamic> body,
  );

  @POST("/authenticate/token/")
  @FormUrlEncoded()
  Future<_ApiAuthManager> refreshToken(
    @Body() Map<String, dynamic> body,
  );
}

class DomisyDio {
  DomisyDio._();

  factory DomisyDio() => _instance;

  static final DomisyDio _instance = DomisyDio._();
  static const String apiBaseUrl = "http://51.68.230.193/";

  _ApiAuthManager apiAuthManager;

  static DomisyDio getInstance() {
    if (DomisyDio._instance == null) {
      new DomisyDio();
    }
    return DomisyDio._instance;
  }

  static Future<void> authenticate(username, password) async {
    DomisyDio._instance.apiAuthManager =
        await _ApiAuthManager.authenticate(username, password);
  }

  static refreshToken() {
    if (DomisyDio._instance?.apiAuthManager != null) {
      DomisyDio._instance.apiAuthManager.refreshToken();
    }
  }
}

class _ApiAuthManager {
  String token;
  String tokenType;

  _ApiAuthManager({this.token, this.tokenType});
  factory _ApiAuthManager.fromJson(Map<String, dynamic> json) {
    return _ApiAuthManager(
        token: json["access_token"], tokenType: json["token_type"]);
  }

  static Future<_ApiAuthManager> authenticate(username, password) async {
    final client = ApiAuthManagerRestClient(Dio());
    return await client.getToken({
      'grant_type': 'password',
      'client_id': 'tOoidzgtECmD1CpuQ2eWlovn8IR1ckkz1Up9fIea',
      'client_secret':
          'vy4qvh4iVgNmTpVigubGMqidEKzeRAbX3SvP3WG0OCf0ifiTv3eKpCrSoo9w2BTCBpnlBqlnv8MdScr2MwTjwfmRMmDzgx5Kefg37Qi7MXYQdEpllj1woQ8irn7x6g2B',
      'password': password,
      'username': username
    });
  }

  void refreshToken() {
    final client = ApiAuthManagerRestClient(Dio());
    client.refreshToken({
      'grant_type': 'refresh_token',
      'client_id': 'tOoidzgtECmD1CpuQ2eWlovn8IR1ckkz1Up9fIea',
      'client_secret':
          'vy4qvh4iVgNmTpVigubGMqidEKzeRAbX3SvP3WG0OCf0ifiTv3eKpCrSoo9w2BTCBpnlBqlnv8MdScr2MwTjwfmRMmDzgx5Kefg37Qi7MXYQdEpllj1woQ8irn7x6g2B',
      'refresh_token': this.token
    });
  }

  String getTokenHeaderValue() {
    return "${this.tokenType} ${this.token}";
  }
}
