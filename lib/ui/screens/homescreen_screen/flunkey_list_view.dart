import 'dart:convert';

import 'package:android_lyrics_player/data/models/flunkey_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:android_lyrics_player/utils/constants/strings.dart';

import '../../widgets/dipslay_snackbar.dart';

class ProductListView extends StatelessWidget {
  ProductListView(this.model, {super.key});

  final List<ProductModel>? model;
  String quantity = "1";
  var encoder = new JsonEncoder.withIndent("     ");

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: model?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {
                displaySnackbar(context, "${model?[index].pname} selected!")
              },
              child: Card(
                elevation: 3,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      CachedNetworkImage(
                        height: 100,
                        width: 100,
                        imageUrl:  model?[index].imageUrl ?? '',
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                      Container(
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //Center Column contents horizontally,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "${model?[index].pname} - ${model?[index].pcategory}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("${model?[index].pdetails}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Price: ${model?[index].pcost} ₹" +
                                      "  Available: ${model?[index].pavailability}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: TextEditingController()
                                ..text = model?[index].pquantity ?? '1',
                              textAlign: TextAlign.center,
                              onChanged: (text) {
                                model?[index].pquantity = text;
                                Strings.jsonDb = encoder.convert(model);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Qty',
                              ),
                              style: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.0,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
