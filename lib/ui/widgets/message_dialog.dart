import 'package:flutter/material.dart';
import 'package:android_lyrics_player/utils/constants/strings.dart';

class MessageDialog extends StatefulWidget {
  MessageDialog({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MessageDialogState createState() => new _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.blueAccent[800],
    minimumSize: Size(308, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Cart Items'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(Strings.jsonDb),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          _showcontent();
        },
        child: Text('Proceed to Buy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
