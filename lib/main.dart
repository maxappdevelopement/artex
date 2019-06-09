import 'package:artex/models/art.dart';
import 'package:artex/pages/art_admin.dart';
import 'package:artex/pages/art_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:artex/redux/reducers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(body: ArtCamera() /* ArtAdminPage() */),
      ),
    );
  }
}
