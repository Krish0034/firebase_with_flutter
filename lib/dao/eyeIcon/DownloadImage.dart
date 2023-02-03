import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../utils/CustomsColors.dart';

class DownloadImage extends StatelessWidget {
  String path;
  DownloadImage({Key? key,required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: PinchZoom(
            resetDuration:Duration(seconds: 2),
            onZoomEnd:(){},
            maxScale: 2.2,
            zoomEnabled: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(path),
            ),
          )
      ),
    );
  }
}
