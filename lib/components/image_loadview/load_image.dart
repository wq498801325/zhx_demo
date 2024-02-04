
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zhx_demo/util/global.dart';



/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  const LoadImage(this.image, {
    Key? key,
    required this.width,
    required this.height,
    this.memCache =true,
    this.fit = BoxFit.cover,
    this.format = 'png',
    this.holderImg = 'lib/assets/images/loading.png', required this.size
  }): super(key: key);
  
  final String image;
  final bool memCache;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;
  final int size;


  @override
  Widget build(BuildContext context) {
    if (image==null|| image.isEmpty) {
      return  LoadAssetImage(holderImg,
        height: height,
        width: width,
        fit: fit,
        format: format
      );
    } else {
      if (image.startsWith('http')) {
        return  CachedNetworkImage(
          // imageUrl: image,
          imageUrl: size==null?image:image+'?x-image-process=style/w'+size.toString(),
          placeholder: (context, url) => holderImg.isEmpty?Container():LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          errorWidget: (context, url, error) => LoadAssetImage('lib/assets/images/error.png', height: height, width: width, fit: fit),
          // memCacheHeight: 1000,
          memCacheWidth: 1100,
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        return LoadAssetImage(
            image,
            height: height,
            width: width,
            fit: fit,
            format: format, color: null,
        );
      }
    }
  }


  double next(int min, int max) {
    final _random = new Random();
    return (min + _random.nextInt(max - min)).toDouble();
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  
  const LoadAssetImage(this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.format = 'png',
    this.color
  }): super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height,
      width: width,
      fit: fit,
      color: color,
      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}

