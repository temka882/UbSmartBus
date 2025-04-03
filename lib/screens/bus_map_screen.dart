import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BusMapScreen extends StatefulWidget {
  @override
  _BusMapScreenState createState() => _BusMapScreenState();
}

class _BusMapScreenState extends State<BusMapScreen> {
  late GoogleMapController _mapController;
  BitmapDescriptor? _busIcon;
  BitmapDescriptor? _stopIcon; // For custom bus stop icon
  Set<Polyline> _polylines = {};
  List<int> _busIndices = [0, 0]; // Track positions of 2 buses
  List<LatLng> _busPositions = []; // Positions of 2 buses

  // 🚏 Bus Stops with Information
  final List<Map<String, dynamic>> _busStops = [
    {"name": "Stop 1 - Main Square", "position": LatLng(47.928312, 106.907537)},
    {
      "name": "Stop 2 - Central Market",
      "position": LatLng(47.933308, 106.906227),
    },
    {"name": "Stop 3 - University", "position": LatLng(47.937506, 106.909450)},
    {"name": "Stop 4 - Mall", "position": LatLng(47.939502, 106.912726)},
    {"name": "Stop 5 - Park", "position": LatLng(47.935011, 106.915998)},
    {
      "name": "Stop 6 - Train Station",
      "position": LatLng(47.931219, 106.916689),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadBusIcon();
    _loadStopIcon(); // Load custom bus stop icon
    _fetchRoutePolylines();
    _initializeBusPositions();
    _simulateBusMovement();
  }

  // Loading bus icon from assets
  Future<void> _loadBusIcon() async {
    _busIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/bus_icon.png', // Your custom bus icon
    );
    setState(() {});
  }

  // Loading bus stop icon from assets
  Future<void> _loadStopIcon() async {
    _stopIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/bus_stop_icon.png', // Your custom bus stop icon
    );
    setState(() {});
  }

  void _initializeBusPositions() {
    _busPositions = [
      _busStops[0]["position"] as LatLng,
      _busStops[2]["position"] as LatLng,
    ];
  }

  void _simulateBusMovement() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _busIndices[0] = (_busIndices[0] + 1) % _busStops.length;
        _busPositions[0] = _busStops[_busIndices[0]]["position"] as LatLng;
      });
    });

    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _busIndices[1] = (_busIndices[1] + 1) % _busStops.length;
        _busPositions[1] = _busStops[_busIndices[1]]["position"] as LatLng;
      });
    });
  }

  Future<void> _fetchRoutePolylines() async {
    String apiKey = "AIzaSyBphz8bzQNWfOj9KgLUrwF2jd-76gOcxSY";
    _polylines.clear();

    for (int i = 0; i < _busStops.length; i++) {
      int nextIndex = (i + 1) % _busStops.length;

      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_busStops[i]["position"].latitude},${_busStops[i]["position"].longitude}&destination=${_busStops[nextIndex]["position"].latitude},${_busStops[nextIndex]["position"].longitude}&mode=driving&key=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["routes"].isEmpty) {
          print(
            "No route found for ${_busStops[i]["name"]} -> ${_busStops[nextIndex]["name"]}",
          );
          continue;
        }

        final points = data["routes"][0]["overview_polyline"]["points"];
        final List<LatLng> polylinePoints = _decodePolyline(points);

        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route_$i"),
              points: polylinePoints,
              color: Colors.orange,
              width: 5,
            ),
          );
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  void _showStopInfo(String stopName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(stopName),
          content: Text("Details of $stopName"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _busStops[0]["position"] as LatLng,
          zoom: 15,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: {
          // 🚏 Markers for Bus Stops (Clickable)
          ..._busStops.map(
            (stop) => Marker(
              markerId: MarkerId(stop["name"]),
              position: stop["position"] as LatLng,
              infoWindow: InfoWindow(title: stop["name"]),
              onTap: () {
                _showStopInfo(stop["name"]);
              },
              icon:
                  _stopIcon ??
                  BitmapDescriptor.defaultMarker, // Custom icon for bus stop
            ),
          ),

          // 🚌 Markers for Buses (Ensure custom bus icon is set)
          if (_busIcon != null)
            ..._busPositions.asMap().entries.map(
              (entry) => Marker(
                markerId: MarkerId("bus_${entry.key}"),
                position: entry.value,
                icon: _busIcon!, // Use custom bus icon
                infoWindow: InfoWindow(
                  title: "Bus ${entry.key + 1}",
                  snippet:
                      "Next Stop: ${_busStops[_busIndices[entry.key]]["name"]}",
                ),
              ),
            ),
        },
        polylines: _polylines,
      ),
    );
  }
}




//pubspec.yaml
//google_maps_flutter: ^2.10.0
//location: ^8.0.0
//http: ^1.3.0


//ios/Runner/AppDelegate.swift
// import Flutter
// import UIKit
// import GoogleMaps

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GMSServices.provideAPIKey("AIzaSyBphz8bzQNWfOj9KgLUrwF2jd-76gOcxSY")
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }



//ios/Runner/Info.plist
// <?xml version="1.0" encoding="UTF-8"?>
// <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
// <plist version="1.0">
// <dict>
// 	<key>CFBundleDevelopmentRegion</key>
// 	<string>$(DEVELOPMENT_LANGUAGE)</string>
// 	<key>CFBundleDisplayName</key>
// 	<string>Ub Smart Bus Diploma</string>
// 	<key>CFBundleExecutable</key>
// 	<string>$(EXECUTABLE_NAME)</string>
// 	<key>CFBundleIdentifier</key>
// 	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
// 	<key>CFBundleInfoDictionaryVersion</key>
// 	<string>6.0</string>
// 	<key>CFBundleName</key>
// 	<string>ub_smart_bus_diploma</string>
// 	<key>CFBundlePackageType</key>
// 	<string>APPL</string>
// 	<key>CFBundleShortVersionString</key>
// 	<string>$(FLUTTER_BUILD_NAME)</string>
// 	<key>CFBundleSignature</key>
// 	<string>????</string>
// 	<key>CFBundleVersion</key>
// 	<string>$(FLUTTER_BUILD_NUMBER)</string>
// 	<key>LSRequiresIPhoneOS</key>
// 	<true/>
// 	<key>UILaunchStoryboardName</key>
// 	<string>LaunchScreen</string>
// 	<key>UIMainStoryboardFile</key>
// 	<string>Main</string>
// 	<key>UISupportedInterfaceOrientations</key>
// 	<array>
// 		<string>UIInterfaceOrientationPortrait</string>
// 		<string>UIInterfaceOrientationLandscapeLeft</string>
// 		<string>UIInterfaceOrientationLandscapeRight</string>
// 	</array>
// 	<key>UISupportedInterfaceOrientations~ipad</key>
// 	<array>
// 		<string>UIInterfaceOrientationPortrait</string>
// 		<string>UIInterfaceOrientationPortraitUpsideDown</string>
// 		<string>UIInterfaceOrientationLandscapeLeft</string>
// 		<string>UIInterfaceOrientationLandscapeRight</string>
// 	</array>
// 	<key>CADisableMinimumFrameDurationOnPhone</key>
// 	<true/>
// 	<key>UIApplicationSupportsIndirectInputEvents</key>
// 	<true/>
// 	<key>NSLocationWhenInUseUsageDescription</key>
// 	<string>We need your location to show your position on the map.</string>
// 	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
// 	<string>We need your location for continuous tracking on the map.</string>
// </dict>
// </plist>




