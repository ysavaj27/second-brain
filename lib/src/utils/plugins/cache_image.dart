import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'logger.dart';

class CacheImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CacheImage({super.key, required this.url, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: url,
      placeholder: (context, url) {
        return const SpinKitRipple(color: Colors.red,size: 40);
      },
      // progressIndicatorBuilder: (context, url, downloadProgress) =>
      //     CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) {
        logger.d('Error on Cache Image $error \nUrl :$url');
        return const Icon(Icons.error);
      },
    );
  }
}
