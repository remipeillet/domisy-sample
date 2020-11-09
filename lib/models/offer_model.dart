import 'package:domisy_sample/utils/api_auth.dart';
import 'package:domisy_sample/views/offer_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'offer_model.g.dart';

@RestApi(baseUrl: DomisyDio.apiBaseUrl)
abstract class OfferRestClient {
  factory OfferRestClient(Dio dio, {String baseUrl}) = _OfferRestClient;

  @POST("/api/offers/joboffer/list/")
  Future<Response> fetchOffers();

  @GET("/users/{id}")
  Future<Offer> fetchOffer(@Path("id") String id);
}

@JsonSerializable()
class Offer {
  final int id;
  final String title;
  final String content;
  final String picture;

  Offer({this.id, this.title, this.content, this.picture});

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);

  /*factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      category: json['category'],
      city: json['city'],
      source: json['source'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'image_url': imageUrl,
    'category': category,
    'city': city,
    'source': source,
    'username': username,
  };*/

  static String _getCityFromJson(cityJsonObject) {
    debugPrint(cityJsonObject);
    return 'Rennes';
  }
}

class OfferList extends StatelessWidget {
  final List<Offer> offers;

  OfferList({Key key, this.offers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 150.0,
      itemCount: offers.length,
      itemBuilder: (context, index) {
        return OfferListItemCard(
            key: ValueKey('offer_list_item_card_${offers[index].id}'),
            offer: offers[index],
            index: index);
      },
    );
  }
}

class OfferListItemCard extends StatelessWidget {
  final Offer offer;
  final int index;

  OfferListItemCard({Key key, @required this.offer, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: new InkWell(
            onTap: () => {
                  Navigator.pushNamed(context, OfferDetailView.routeName,
                      arguments: {'offer': this.offer})
                },
            child: index?.isEven
                ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: 'offer_picture_${offer.id}',
                        child: Image.network(offer.picture),
                      ),
                    ),
                    Expanded(
                        flex: 3, child: OfferListItemDescription(offer: offer))
                  ])
                : Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Expanded(
                        flex: 3, child: OfferListItemDescription(offer: offer)),
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: 'offer_picture_${offer.id}',
                        child: Image.network(offer.picture),
                      ),
                    ),
                  ])));
  }
}

class OfferListItemDescription extends StatelessWidget {
  final Offer offer;

  OfferListItemDescription({Key key, @required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Hero(
              tag: 'offer_title_${offer.id}',
              child: Material(
                type: MaterialType.transparency, // likely needed
                child: Text(
                  offer.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          Text('Rpeillet'),
          Hero(
              tag: 'offer_content_${offer.id}',
              child: Material(
                type: MaterialType.transparency, // likely needed
                child: Text(offer.content.length < 100
                    ? offer.content
                    : "${offer.content.substring(0, 100)}..."),
              ))
        ],
      ),
    );
  }
}

class OfferDetailCard extends StatelessWidget {
  final Offer offer;

  const OfferDetailCard({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        children: [
          Hero(
            tag: 'offer_picture_${offer.id}',
            child: Image.network(offer.picture),
          ),
          Hero(
            tag: 'offer_title_${offer.id}',
            child: Material(
              type: MaterialType.transparency, // likely needed
              child: Text(
                offer.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Hero(
              tag: 'offer_content_${offer.id}',
              child: Material(
                  type: MaterialType.transparency, // likely needed
                  child: Text(offer.content))),
        ],
      ),
    );
  }
}
