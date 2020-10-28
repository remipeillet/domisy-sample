import 'package:domisy_sample/main.dart';
import 'package:domisy_sample/views/offer_view.dart';
import 'package:domisy_sample/views/tile_menu_view.dart';
import 'package:flutter/material.dart';

import 'models/offer_model.dart';

class DomisyRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Domisy'));
        break;
      case TileHome2.routeName:
        return MaterialPageRoute(builder: (context) => TileHome2());
        break;
      case OfferListView.routeName:
        return MaterialPageRoute(builder: (context) => OfferListView());
        break;
      case OfferDetailView.routeName:
        if (args.containsKey('offer') && args['offer'] is Offer) {
          return MaterialPageRoute(
              builder: (context) => OfferDetailView(offer: args['offer']));
        }
        return MaterialPageRoute(builder: (context) => OfferListView());
      default:
        return MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Domisy'));
        break;
    }
  }
}
