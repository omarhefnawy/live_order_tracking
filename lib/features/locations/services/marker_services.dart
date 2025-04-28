import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';


class MarkerServices{
  static  // Method to get images and convert them to Uint8List
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

}