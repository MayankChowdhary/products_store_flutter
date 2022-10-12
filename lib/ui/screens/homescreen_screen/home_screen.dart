import 'dart:collection';

import 'package:android_lyrics_player/data/models/flunkey_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/cubit/internet_cubit.dart';
import '../../../utils/constants/strings.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/message_dialog.dart';
import '../../widgets/message_view.dart';
import '../../../controller/bloc/flunkey_list_bloc/flunkey_list_bloc.dart'
    as slb;
import 'flunkey_list_view.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = Strings.homeScreenRoute;

  ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductListScreen> {
  String? _value = 'ALL';
  late List<DropdownMenuItem<String>> menuItems = [];


  void addDropDownItems(List<ProductModel> model) {
    menuItems.clear();
    menuItems.add(new DropdownMenuItem(
      child: new Text("All Category"),
      value: "ALL",
    ));
    List<String> catItems = [];
    model.forEach((element) {
      catItems.add(element.pcategory.toString());
    });
    var distinctCat = catItems.toSet().toList();
    distinctCat.forEach((element) {
      menuItems.add(new DropdownMenuItem(
        child: new Text(element),
        value: element,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    String trackId  = args.arg1!;*/

    BlocProvider.of<slb.SongBloc>(context).add(slb.LoadSongListEvent());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Text("    Products"),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: new Theme(
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: _value,
                    items: menuItems,
                    onChanged: (String? value) {
                      setState(() => _value = value);
                    },
                  ),
                ),
                data: new ThemeData.dark(),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff764abc),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: TextField(
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                readOnly: true,
                decoration:
                    new InputDecoration.collapsed(hintText: 'Flutter App'),
              ),
              accountEmail: TextField(
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                readOnly: true,
                decoration:
                    new InputDecoration.collapsed(hintText: 'Android Studio'),
              ),
              currentAccountPicture: Image.asset('assets/usericon.png'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body:
          BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
        if (state is InternetConnected) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<slb.SongBloc, slb.SongListState>(
                  builder: (context, state) {
                    if (state is slb.SongLoadingState) {
                      return loadingWidget();
                    } else if (state is slb.SongLoadedState) {
                      addDropDownItems(state.items);
                      List<ProductModel> filteredList = [];
                      if (_value == "ALL") {
                        filteredList = state.items;
                      } else {
                        filteredList = state.items
                            .where((i) => i.pcategory == _value)
                            .toList();
                      }
                      return ProductListView(filteredList);
                    } else if (state is slb.SongErrorState) {
                      return showMessageView(message: "Loading Products...");
                    } else {
                      return showMessageView(message: "Loading Products...");
                    }
                  },
                ),
                MessageDialog(title: 'Products'),
              ],
            ),
          );
        } else if (state is InternetDisconnected) {
          return showMessageView(message: "No Internet Available");
        } else {
          return showMessageView(message: "Loading Products...");
        }
      }),
    );
  }
}
