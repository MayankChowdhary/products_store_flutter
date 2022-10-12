import 'package:flutter/cupertino.dart';

Widget showMessageView({String message = "Something went wrong"}) => Center(
    child: Text(message,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
