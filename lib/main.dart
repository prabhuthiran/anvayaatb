import 'dart:async';

import 'package:flutter/material.dart';
import 'map_provider.dart';
import 'package:location/location.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Static Maps',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green,
      ),
      home: new MyHomePage(title: 'Nearby'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location _location = new Location();
  StreamSubscription<Map<String, double>> _locationSub;
  Map<String, double> _currentLocation;
  List locations = [];
  String googleMapsApi = 'AIzaSyAqrEcpjsxC5lgWTclM_R4AXKUivavl62Y';
  TextEditingController _latController = new TextEditingController();
  TextEditingController _lngController = new TextEditingController();
  int zoom = 15;

  @override
  void initState() {
    super.initState();
    _locationSub =
        _location.onLocationChanged.listen((Map<String, double> locationData) {
      setState(() {
        _currentLocation = {
          "latitude": locationData["latitude"],
          "longitude": locationData['longitude'],
        };
      });
    });
  }

  Future<Null> findUserLocation() async {
    Map<String, double> location;
    try {
      location = await _location.getLocation;
      setState(() {
        _currentLocation = {
          "latitude": location["latitude"],
          "longitude": location['longitude'],
        };
      });
      print(location);
      handleSubmitNewMarker();
    } catch (exception) {
      print(exception);
    }
  }

  void handleSubmitNewMarker() {
    String lat;
    String lng;
    lat = _latController.text;
    lng = _lngController.text;

    setState(() {
      locations.add(
        {"latitude": lat, "longitude": lng
      });
       locations.add(
      {"latitude": 13.073226, "longitude": 80.260921
      });
  locations.add(
     {"latitude": 13.0325754, "longitude": 80.24585189999999
      });
        locations.add(
     {"latitude": 13.059537, "longitude": 80.242479
      });
    
    });
    _lngController.clear();
    _latController.clear();
  }

  void increaseZoom() {
    setState(() {
      zoom = zoom + 1;
    });
  }

  void decreaseZoom() {
    setState(() {
      zoom = zoom - 1;
    });
  }

  void resetMap() {
    setState(() {
      _currentLocation = null;
      locations = [];
      zoom = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isActiveColor =
        (locations.length <= 1) ? Theme.of(context).primaryColor : Colors.grey;

    Widget body = new Container(
      child: new Column(
        children: <Widget>[
          // Map Section w/ +/- buttons
          new Stack(
            children: <Widget>[
              new StaticMap(googleMapsApi,
                  currentLocation: _currentLocation,
                  markers: locations,
                  zoom: zoom),
              new Positioned(
                top: 130.0,
                right: 10.0,
                child: new FloatingActionButton(
                  onPressed: (locations.length <= 1) ? increaseZoom : null,
                  backgroundColor: isActiveColor,
                  child: new Icon(
                    const IconData(0xe145, fontFamily: 'MaterialIcons'),
                  ),
                ),
              ),
              new Positioned(
                top: 190.0,
                right: 10.0,
                child: new FloatingActionButton(
                  onPressed: (locations.length <= 1) ? decreaseZoom : null,
                  backgroundColor: isActiveColor,
                  child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                  ),
                ),
              ),
            ],
          ),
          // Get Location & Reset Button Section
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                  onPressed: findUserLocation,
                  child: new Text('ATM'),
                  color: Theme.of(context).primaryColor,
                ),
                new RaisedButton(
                  onPressed: resetMap,
                  child: new Text('ATB'),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          // Marker Placement Input Section
    
        ],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: body,
    );
  }
}
