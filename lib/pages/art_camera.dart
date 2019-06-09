import 'package:flutter/material.dart';

class Photo {
  String title;
  String subtitle;
  String image;

  Photo(this.title, this.subtitle, this.image);
}

class ArtCamera extends StatelessWidget {
  final List<Photo> photos = [
    Photo('Skriet', 'RenneSaince', 'images/flower2.png'),
    Photo('Nattvarden', 'Berit', 'images/flower2.png'),
    Photo('Bajjen', 'someArt', 'images/flower2.png'),
    Photo('Rååtan', 'okey', 'images/flower2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              children: <Widget>[
                _buildIconsRow(),
                Expanded(
                    child: SafeArea(
                        top: false, bottom: false, child: _buildGridView())),
              ],
            )));
  }


  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: EdgeInsets.all(4.0),
      children: photos.map((Photo photo) {
        return GridTile(
          footer: GestureDetector(
            onTap: () {},
            child: GridTileBar(
                backgroundColor: Colors.black38,
                title: Text(photo.title),
                subtitle: Text(photo.subtitle),
                trailing: Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ),
          ), child: Image.asset(photo.image, fit: BoxFit.cover,)  
          
         
        );
      }).toList(),
    );
  }

  Widget _buildIconsRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Icon(Icons.call), Text('Call')],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Icon(Icons.mail), Text('Mail')],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Icon(Icons.share), Text('Share')],
        ),
      ],
    );
  }
}

/*  return GridView.count(
      crossAxisCount: 4,
      children: new List<Widget>.generate(16, (index) {
        return new GridTile(
          child: new Card(
              color: Colors.blue.shade200,
              child: new Center(
                child: new Text('tile $index'),
              )),
        );
      }),
    );
  } */
