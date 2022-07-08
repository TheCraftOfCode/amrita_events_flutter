import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget networkImage(url) {
  print(url);
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: url != null && url != ''
        ? CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (context, url) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => const Image(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.fill,
            ),
          )
        : const Image(
            image: AssetImage('assets/background_image.png'),
            fit: BoxFit.fill,
          ),
  );
}
