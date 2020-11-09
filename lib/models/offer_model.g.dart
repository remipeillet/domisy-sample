// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map json) {
  return Offer(
    id: json['id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    picture: json['picture'] as String,
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'picture': instance.picture,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OfferRestClient implements OfferRestClient {
  _OfferRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://51.68.230.193/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Offer>> fetchOffers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/api/offers/joboffer/list/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Offer.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Offer> fetchOffer(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/users/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Offer.fromJson(_result.data);
    return value;
  }
}
