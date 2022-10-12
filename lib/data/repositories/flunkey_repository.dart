import 'dart:convert';

import 'package:android_lyrics_player/data/models/flunkey_model.dart';
import 'package:flutter/services.dart';
import 'package:android_lyrics_player/utils/constants/strings.dart';

class ProductRepository {
  final queryParameters = {
    'pageNo': '0',
    'size': '100',
    'direction': 'asc',
  };

  Future<List<ProductModel>> getSongs() async {
    final List parsedList = json.decode(Strings.jsonDb);
    List<ProductModel> productList =
        parsedList.map((val) => ProductModel.fromJson(val)).toList();
    return productList;
  }
}
