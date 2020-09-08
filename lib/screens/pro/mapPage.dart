import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'map_pin_pill.dart';
import 'pin_pill_info.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(18.5204, 73.8567);
const LatLng DEST_LOCATION = LatLng(19.0760, 72.8777);

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = 'API KEY';
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;

  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  BehaviorSubject<double> radius = BehaviorSubject();
  Stream<dynamic> query;
  StreamSubscription subscription;
  var firstPosition;

  @override
  void initState() {
    super.initState();

    location = new Location();
    polylinePoints = PolylinePoints();

    setSourceAndDestinationIcons();

    setInitialLocation();
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/destination_map_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();

    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onTap: (LatLng loc) {
                pinPillPosition = -100;
              },
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(Utils.mapStyles);
                _controller.complete(controller);

                showPinsOnMap();
              }),
          MapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedPin: currentlySelectedPin),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
                child: Text("START"),
                onPressed: () {
                  clearFirestore();
                  subscription =
                      location.onLocationChanged.listen((LocationData cLoc) {
                    currentLocation = cLoc;
                    updatePinOnMap();
                    _addGeoPoint();
                  });
                }),
            RaisedButton(
                child: Text("STOP"),
                onPressed: () {
                  subscription?.cancel();
                  _startQuery();
                }),
          ],
        ),
      ),
    );
  }

  clearFirestore() {
    firestore.collection('locations').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      _markers
          .add(getMarker(currentLocation.latitude, currentLocation.longitude));
      sourcePinInfo.location = pinPosition;
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition,
          icon: sourceIcon));
    });
  }

  Marker getMarker(lat, lng) {
    return Marker(
      markerId: MarkerId("${lat}_${lng}"),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: 'name',
        snippet: 'address',
      ),
    );
  }

  Future<DocumentReference> _addGeoPoint() async {
    var pos = await location.getLocation();
    var chaeckUpdate = await compare(pos);
    if (chaeckUpdate) {
      GeoFirePoint point =
          geo.point(latitude: pos.latitude, longitude: pos.longitude);
      return firestore
          .collection('locations')
          .add({'position': point.data, 'name': 'Yay I can be queried!'});
    }
  }

  Future<bool> compare(LocationData pos) async {
    if (firstPosition == null) {
      firstPosition = pos;
      return true;
    }
    if ((firstPosition.latitude).toStringAsFixed(5) ==
            (pos.latitude).toStringAsFixed(5) &&
        (firstPosition.longitude).toStringAsFixed(5) ==
            (pos.longitude).toStringAsFixed(5)) {
      return false;
    } else {
      firstPosition = pos;
      return true;
    }
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print("documentList : - $documentList");
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      _markers.add(getMarker(pos.latitude, pos.longitude));
    });
    setState(() {});
  }

  Future<List<LatLng>> _startQuery() async {
    CollectionReference document = Firestore.instance.collection("locations");
    List<LatLng> routeCoords = [];
    document.snapshots().forEach((element) {
      for (int i = 0; i < element.documents.length; i++) {
        GeoPoint pos = element.documents[i].data['position']['geopoint'];
        LatLng latLng = LatLng(pos.latitude, pos.longitude);
        routeCoords.add(latLng);
      }
      setPolylines2(routeCoords[0], routeCoords[routeCoords.length - 1]);
      print("THis is one time");
    });
    return routeCoords;
  }

  void setPolylines2(LatLng origin, LatLng destination) async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        origin.latitude,
        origin.longitude,
        destination.latitude,
        destination.longitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 2,
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
