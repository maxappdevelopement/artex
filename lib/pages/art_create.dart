import 'package:flutter/material.dart';
import 'package:artex/models/view_model.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:artex/models/art.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArtCreatePageState();
  }
}

class _ArtCreatePageState extends State<ArtCreatePage> {
  ViewModel viewModel;

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null
  };

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = 'SEK';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          this.viewModel = viewModel;
          return Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          _buildTitleTextField(),
                          _buildDescriptionTextField(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Container(child: _buildPriceTextField()),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 32.0),
                                child: _buildDropDownMenu(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _buildSaveButton(),
                  ],
                )
              ],
            ),
          );
        });
  }

  _submitForm() {
    if (!_formKey.currentState.validate()) {
      print("not valid form");
      return;
    }
    _formKey.currentState.save();

    create(_formData);
  }

  create(Map<String, dynamic> formdata) {
    final CollectionReference artCollection =
        Firestore.instance.collection('artObjects');

    String creationDate = new DateTime.now().toUtc().toIso8601String();

    Firestore.instance.runTransaction((Transaction tx) async {
      var _result = await artCollection.add({
        'title': _formData['title'],
        'description': _formData['description'],
        'price': _formData['price'],
        'date': creationDate
      });

      var document = Firestore.instance
          .collection('artObjects')
          .document(_result.documentID);
      document.get().then((document) {
        
        Item item = Item(
          id: _result.documentID,
          title: document['title'],
          description: document['description'],
          price: document['price'],
          date: document['date'],
        );

        viewModel.onAddItem(item);
      });
    });
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      validator: (String value) {
        if (value.isEmpty) {
          return "Title must not be empty";
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: TextFormField(
        maxLines: 8,
        decoration: InputDecoration(
            hintText: 'Description', border: OutlineInputBorder()),
        validator: (String value) {},
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      validator: (String value) {
        if (!RegExp(r'^(?:[1-9]\d*|0)?(?:[\.\,]\d+)?$').hasMatch(value)) {
          return "Price should be a number";
        }
      },
      onSaved: (String value) {
        double number = double.parse("$value");
        _formData['price'] = number;
      },
    );
  }

  DropdownButton _buildDropDownMenu() {
    return DropdownButton<String>(
      isDense: true,
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['SEK', 'EUR', 'USD']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Container _buildSaveButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
      child: FloatingActionButton.extended(
        onPressed: () {
          _submitForm();
          
        }, 
        icon: Icon(Icons.navigate_next),
        label: Text("Save"),
      ),
    );
  }
}
