import 'dart:convert';

import 'package:domisy_sample/views/offer_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Offer {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String category;
  final String city;
  final String username;
  final String source;
  final String detailUrl;

  Offer(
      {this.id,
      this.title,
      this.content,
      this.imageUrl,
      this.category,
      this.city,
      this.source,
      this.username,
      this.detailUrl});

  factory Offer.fromJson(Map<String, dynamic> json) {
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
      };

  static List<Offer> _parseOffers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Offer>((json) => Offer.fromJson(json)).toList();
  }

  static Future<List<Offer>> fetchOffers(http.Client client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      return _parseOffers('''[
        {"id": 1945,
        "title": "Ma premiere offre",
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id lorem quis libero porta porttitor.",
        "image_url": "https://picsum.photos/200?random=29",
        "category": "Ménage",
        "city": "Rennes",
        "source":"jmp",
        "username": "rpeillet"
        },
        {"id": 2964,
        "title": "Ma seconde offre",
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id lorem quis libero porta porttitor. Donec volutpat, turpis ut interdum consequat, ligula felis blandit lectus, ac laoreet tellus dolor nec augue. Nullam a quam eget nisi efficitur rhoncus id interdum augue. Sed rutrum et metus et pharetra. Ut vel nulla consectetur, facilisis erat eget, luctus lacus. Donec convallis purus at elementum tincidunt. Pellentesque vitae sodales justo, sollicitudin posuere augue. Nulla interdum non justo eget ultrices. Phasellus ornare nisi sit amet dolor suscipit mattis. Nunc non pharetra erat. Mauris facilisis nunc vel lobortis bibendum. Aenean ut felis et magna tristique ullamcorper.",
        "image_url": "https://picsum.photos/200?random=269",
        "category": "Ménage",
        "city": "Rennes",
        "source":"jmp",
        "username": "rpeillet"
        },
        {"id": 125634,
        "title": "Ma troisieme offre",
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id lorem quis libero porta porttitor. Donec volutpat, turpis ut interdum consequat, ligula felis blandit lectus, ac laoreet tellus dolor nec augue. Nullam a quam eget nisi efficitur rhoncus id interdum augue. Sed rutrum et metus et pharetra. Ut vel nulla consectetur, facilisis erat eget, luctus lacus. Donec convallis purus at elementum tincidunt. Pellentesque vitae sodales justo, sollicitudin posuere augue. Nulla interdum non justo eget ultrices. Phasellus ornare nisi sit amet dolor suscipit mattis. Nunc non pharetra erat. Mauris facilisis nunc vel lobortis bibendum. Aenean ut felis et magna tristique ullamcorper.",
        "image_url": "https://picsum.photos/200?random=2836",
        "category": "Ménage",
        "city": "Rennes",
        "source":"jmp",
        "username": "rpeillet"
        },
        {"id": 28,
        "title": "Ma quatrième offre",
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id lorem quis libero porta porttitor. Donec volutpat, turpis ut interdum consequat, ligula felis blandit lectus, ac laoreet tellus dolor nec augue. Nullam a quam eget nisi efficitur rhoncus id interdum augue. Sed rutrum et metus et pharetra. Ut vel nulla consectetur, facilisis erat eget, luctus lacus. Donec convallis purus at elementum tincidunt. Pellentesque vitae sodales justo, sollicitudin posuere augue. Nulla interdum non justo eget ultrices. Phasellus ornare nisi sit amet dolor suscipit mattis. Nunc non pharetra erat. Mauris facilisis nunc vel lobortis bibendum. Aenean ut felis et magna tristique ullamcorper.",
        "image_url": "https://picsum.photos/200?random=45",
        "category": "Ménage",
        "city": "Rennes",
        "source":"jmp",
        "username": "rpeillet"
        },
        {"id": 97856,
        "title": "Ma cinquième offre",
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id lorem quis libero porta porttitor. Donec volutpat, turpis ut interdum consequat, ligula felis blandit lectus, ac laoreet tellus dolor nec augue. Nullam a quam eget nisi efficitur rhoncus id interdum augue. Sed rutrum et metus et pharetra. Ut vel nulla consectetur, facilisis erat eget, luctus lacus. Donec convallis purus at elementum tincidunt. Pellentesque vitae sodales justo, sollicitudin posuere augue. Nulla interdum non justo eget ultrices. Phasellus ornare nisi sit amet dolor suscipit mattis. Nunc non pharetra erat. Mauris facilisis nunc vel lobortis bibendum. Aenean ut felis et magna tristique ullamcorper.",
        "image_url": "https://picsum.photos/200?random=578",
        "category": "Ménage",
        "city": "Rennes",
        "source":"jmp",
        "username": "rpeillet"
        },
        {"id": 1835,
        "title": "Ma sixième offre",
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id lorem quis libero porta porttitor. Donec volutpat, turpis ut interdum consequat, ligula felis blandit lectus, ac laoreet tellus dolor nec augue. Nullam a quam eget nisi efficitur rhoncus id interdum augue. Sed rutrum et metus et pharetra. Ut vel nulla consectetur, facilisis erat eget, luctus lacus. Donec convallis purus at elementum tincidunt. Pellentesque vitae sodales justo, sollicitudin posuere augue. Nulla interdum non justo eget ultrices. Phasellus ornare nisi sit amet dolor suscipit mattis. Nunc non pharetra erat. Mauris facilisis nunc vel lobortis bibendum. Aenean ut felis et magna tristique ullamcorper.",
        "image_url": "https://picsum.photos/200?random=7576",
        "category": "Ménage",
        "city": "Rennes",
        "source":"jmp",
        "username": "rpeillet"
        }
        ]''');
      //return _parseOffers(response.body);
    }
    throw Exception('Failed to load offer list');
  }

  static Future<Offer> fetchOffer(http.Client client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      return Offer.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load offer');
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
                        child: Image.network(offer.imageUrl),
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
                        child: Image.network(offer.imageUrl),
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
          Text(offer.username),
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
            child: Image.network(offer.imageUrl),
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
