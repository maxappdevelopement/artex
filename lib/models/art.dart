import 'package:flutter/foundation.dart';

class Item {
  final String id;
  final String title;
  final String description;
  final double price;
  final String date;

  Item({
    this.id,
    @required this.title,
    this.description,
    this.price,
    this.date,
  });


  Item.withId({
    @required this.id,
    @required this.title,
    this.description,
    this.price, 
    this.date,
  });

 

  Item copyWith({String id, String title, String description}) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      date: date ?? this.date,
    );
  }

  Item.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'date' : date,
      };
}


class AppState {
  final List<Item> items;

  AppState({
    @required this.items,
  });

  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((i) => Item.fromJson(i)).toList();

  Map toJson() => {'items': items};

  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}


