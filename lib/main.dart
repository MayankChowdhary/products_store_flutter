import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_lyrics_player/utils/constants/strings.dart';

import 'controller/bloc/flunkey_list_bloc/flunkey_list_bloc.dart' as slb;
import 'controller/cubit/internet_cubit.dart';
import 'controller/debug/app_bloc_observer.dart';
import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';
import 'data/repositories/flunkey_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLogged = prefs.getBool("login");
  print("login:" + isLogged.toString());*/
  Strings.jsonDb = await rootBundle.loadString('assets/product_db.json');
  runApp(MyApp(
    appRouter: AppRouter(),
    initialRoute: '/',
    connectivity: Connectivity(),
    key: null,
    songRepository: ProductRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  final ProductRepository songRepository;
  final String initialRoute;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
    required this.songRepository,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<slb.SongBloc>(
            create: (songBlocContext) => slb.SongBloc(songRepository)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: this.initialRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
