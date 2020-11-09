import 'dart:io';

import 'package:domisy_sample/models/offer_model.dart';
import 'package:domisy_sample/utils/api_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class OfferListView extends StatefulWidget {
  static const routeName = '/offers';

  OfferListView({Key key}) : super(key: key);

  _OfferListViewState createState() => _OfferListViewState();
}

class _OfferListViewState extends State<OfferListView> {
  Future<List<Offer>> futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = OfferRestClient(Dio(BaseOptions(headers: {
      HttpHeaders.authorizationHeader:
          DomisyDio.getInstance().apiAuthManager.getTokenHeaderValue()
    }))).fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline.copyWith();
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Hero(
          tag: 'avatar_picture',
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png'),
          ),
        )),
        body: FutureBuilder<List<Offer>>(
          future: futureOffers,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ListView(
                children: [Text("${snapshot.error}")],
              );
            }
            return snapshot.hasData
                ? OfferList(offers: snapshot.data)
                : Center(child: CircularProgressIndicator());

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ));
  }
}

// ***** Offer Detail View Classes *****
class OfferDetailView extends StatefulWidget {
  static const routeName = '/offers/detail';

  final Offer offer;

  OfferDetailView({Key key, this.offer}) : super(key: key);

  _OfferDetailViewState createState() => _OfferDetailViewState();
}

class _OfferDetailViewState extends State<OfferDetailView> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline.copyWith();
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Hero(
          tag: 'avatar_picture',
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png'),
          ),
        )),
        body: OfferDetailCard(offer: widget.offer));
  }
}
