import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

List<Widget> _tiles = const <Widget>[
  const _Example01Tile(Colors.green, Icons.widgets, 'Widgets'),
  const _Example01Tile(Colors.lightBlue, Icons.wifi, 'Wifi'),
  const _Example01Tile(Colors.amber, Icons.panorama_wide_angle, 'Wide Angle'),
  const _Example01Tile(Colors.brown, Icons.map, 'Map'),
  const _Example01Tile(Colors.deepOrange, Icons.send, 'Send'),
  const _Example01Tile(
      Colors.indigo, Icons.airline_seat_recline_extra_rounded, 'Airline Seat'),
  const _Example01Tile(Colors.red, Icons.bluetooth, 'Bluetooth'),
  const _Example01Tile(Colors.pink, Icons.battery_alert, 'Battery Alert'),
  const _Example01Tile(Colors.purple, Icons.desktop_windows, 'Desktop'),
  const _Example01Tile(Colors.blue, Icons.radio, 'Radio'),
];

class TileHome extends StatelessWidget {
  // Replace with server token from firebase console settings.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Tile Home"),
        ),
        body: new Text('Salut'));
  }
}

class TileHome2 extends StatelessWidget {
  // Replace with server token from firebase console settings.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text('Example 01'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                new Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: new StaggeredGridView.count(
                      crossAxisCount: 4,
                      staggeredTiles: _staggeredTiles,
                      children: _tiles,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      padding: const EdgeInsets.all(4.0),
                    )),
                new GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(100, (index) {
                    return Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://picsum.photos/200?random=$index')),
                                ),
                                child: Material(
                                    // <------------------------- Inner Material
                                    type: MaterialType.transparency,
                                    elevation: 6.0,
                                    color: Colors.transparent,
                                    shadowColor: Colors.blue,
                                    child: new InkWell(
                                      splashColor: Color.fromARGB(128, 0, 67, 76),
                                      onTap: () {},
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              left: 0.0,
                                              child: Container(
                                                color: Color.fromARGB(
                                                    128, 0, 0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'super',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )))));
                  }),
                )
              ],
            )));
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData, this.title);

  final Color backgroundColor;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Icon(
                      iconData,
                      color: Colors.white,
                    ),
                    new Text(
                      this.title,
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ])),
        ),
      ),
    );
  }
}
