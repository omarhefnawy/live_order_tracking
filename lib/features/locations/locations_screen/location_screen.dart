import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:order_traking/features/locations/services/marker_services.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_bloc.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_states.dart';
import '../../orders/add_order/data/model/add_order_model.dart';
import '../services/location_services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LocationScreen extends StatefulWidget {
  final AddOrderModel model;
  const LocationScreen({super.key, required this.model});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  Set<Marker> markers = {};
  Set<Polyline> _polylines = {};
  late Position _userposition;
  late Uint8List unitImages;
  String image = 'assets/final.jpg';
  late StreamSubscription<Position> _positionStreamSubscription;

  // Method to load data (images and markers)
  loadData() async {
    // Load image assets and store them in unitImages list
    unitImages = await MarkerServices.getImages(image, 100);

    // Add marker for user's location
    markers.add(
      Marker(
        markerId: MarkerId("user Location"),
        icon: BitmapDescriptor.bytes(unitImages),
        position: LatLng(_userposition.latitude, _userposition.longitude),
        infoWindow: InfoWindow(title: 'Location of the user'),
      ),
    );

    // Add marker for order's location
    markers.add(
      Marker(
        markerId: MarkerId("${widget.model.orderId}"),
        icon: BitmapDescriptor.bytes(unitImages),
        position: LatLng(widget.model.orderLat, widget.model.orderLong),
        infoWindow: InfoWindow(title: '${widget.model.orderName}'),
      ),
    );

    // Update the UI with the new markers
    setState(() {});
  }

  // Get user's position and add marker
  Future<void> getUserPositionAndAddMarker() async {
    try {
      _userposition = await LocationServices.determinePosition();
      if (_userposition == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Getting the location")),
        );
      } else {
        await loadData();
        _drawPolyLines();
        setState(() {}); // Load data after fetching user location
      }
    } catch (e) {
      print("Error determining the location: $e");
    }
  }

  void _drawPolyLines() {
    try {
      _polylines.add(
        Polyline(
          width: 5,
          visible: true,
          polylineId: const PolylineId('simple_route'),
          color: Colors.red,
          points: [
            LatLng(_userposition.latitude, _userposition.longitude),
            LatLng(widget.model.orderLat, widget.model.orderLong),
          ],
        ),
      );
    } catch (e) {
      throw Exception("error drawing the polyline ${e.toString()}");
    }
  }

  // Consolidated method to update both the marker and polyline
  void _updateMarkerAndPolyline(LatLng newPosition) {
    markers.removeWhere((marker) => marker.markerId.value == "user Location");

    markers.add(
      Marker(
        markerId: const MarkerId("user Location"),
        icon: BitmapDescriptor.bytes(unitImages),
        position: newPosition,
        infoWindow: const InfoWindow(title: 'Location of the user'),
      ),
    );

    _polylines.clear();
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('simple_route'),
        color: Colors.red,
        width: 5,
        points: [
          LatLng(_userposition.latitude, _userposition.longitude),
          LatLng(widget.model.orderLat, widget.model.orderLong),
        ],
      ),
    );

    setState(() {});
  }

  // get stream user location
  void _listenStream() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings)
        .listen((Position? position) {
      if (position != null) {
        _userposition = position;
        _updateMarkerAndPolyline(LatLng(_userposition.latitude, _userposition.longitude));
        context.read<AddOrderCubit>().updateUserLatLong(
          widget.model.orderId,
          _userposition.latitude,
          _userposition.longitude,
          "on the way",
        );
         ();
      }
    });
    _checkDeliveryStatus();
  }

  // Check delivery status
  void _checkDeliveryStatus() async {
    final distance = await Geolocator.distanceBetween(
      widget.model.orderLat,
      widget.model.orderLong,
      _userposition.latitude,
      _userposition.longitude,
    );
    if (distance < 600 && widget.model.orderStatus != "Delivered") {
      context.read<AddOrderCubit>().updateStatusToDelevered(widget.model.orderId, "Delivered");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserPositionAndAddMarker();
    _listenStream();
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddOrderCubit, AddOrderStates>(
        listener: (context, state) {
          if (state is OrderDeleveredSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Your order has been delivered!"), backgroundColor: Colors.green),
            );
            Navigator.pop(context);
          }
        },
        child: GoogleMap(
          polylines: _polylines,
          markers: markers,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.model.orderLat, widget.model.orderLong),
            zoom: 14.0, // Set zoom level
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
