import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

class OrderDestination extends StatefulWidget {
  const OrderDestination({super.key});

  @override
  State<OrderDestination> createState() => _OrderDestinationState();
}

class _OrderDestinationState extends State<OrderDestination> {
  LatLng initialLocation = const LatLng(29.378586, 47.990341);
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: dotenv.get('GOOGLE_MAPS_API_KEY'),
      onPlacePicked: (LocationResult result) {
        debugPrint("Place picked: ${result.formattedAddress}");
        Navigator.of(context).pop(result.latLng);
      },
      initialLocation: const LatLng(
        29.378586,
        47.990341,
      ),
      searchInputConfig: const SearchInputConfig(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        autofocus: false,
        textDirection: TextDirection.ltr,
      ),
      searchInputDecorationConfig: const SearchInputDecorationConfig(
        hintText: "Search for a building, street or ...",
      ),
    );
  }
}