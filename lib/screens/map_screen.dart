import 'dart:async';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<MapType> tipoMapas = [
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
    MapType.normal
  ];

  //int indexMapas = 0;

  ValueNotifier<int> indexMapas = ValueNotifier<int>(0);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: indexMapas,
              builder: (context, value, child) {
                return GoogleMap(
                  mapType: tipoMapas[value],
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              }),
          CircularMenuItem(icon: Icons.home, onTap: () => indexMapas.value = 0),
          CircularMenuItem(
              icon: Icons.search, onTap: () => indexMapas.value = 1),
          CircularMenuItem(
              icon: Icons.settings, onTap: () => indexMapas.value = 2),
          CircularMenuItem(icon: Icons.star, onTap: () => indexMapas.value = 3),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
