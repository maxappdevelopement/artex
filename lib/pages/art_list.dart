import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artex/models/view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:artex/models/art.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        //test
        return Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(2.0),
          child: ListView(
            children: viewModel.items
                .map((Item item) => ListTile(
                      title: Text(item.title + item.price.toString()),
                      subtitle: Text(item.description + "  " + item.date),
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          delete(item);  
                          viewModel.onRemoveItem(item);
                        },
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

delete(Item art) async {
  DocumentReference ref = await Firestore.instance.collection('artObjects').document(art.id); 
  Firestore.instance.runTransaction((Transaction transaction) async {
    await transaction.delete(ref);
  });
}

/*   void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final artsFuture = helper.getArts();
      artsFuture.then((result) {
        List<Art> artList = List<Art>();
        count = result.length;
        for (var i = 0; i < count; i++) {
          artList.add(Art.fromObject(result[i]));   
          debugPrint(artList[i].title);  
        }
        setState(() {
          arts = artList;
          count = count;
        });
        debugPrint("Items " + count.toString());
      });
    }); */
/* 

child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.black,
                ),
            itemCount: viewModel.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(viewModel.items[index].body),
                subtitle: Text('hej'),
                onTap: () {}, */
