import 'package:flutter/material.dart';
import 'package:artex/pages/art_list.dart';
import 'package:artex/pages/art_create.dart';

class ArtAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Art'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
                text: 'My art',
              ),
              Tab(
                icon: Icon(Icons.create),
                text: 'Create art',
              ),
            ],
          ),
        ),
        body:
        TabBarView(
          children: <Widget>[ArtListPage(), ArtCreatePage()],
        ),
    
      ),
    );
  }
}
