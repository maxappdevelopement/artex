import 'package:artex/models/art.dart';

class AddItemAction {
  static String _id = "";
  final Item item;

  AddItemAction(this.item) {
    _id = this.item.id;  
  }

  String get id => _id;
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}

class RemoveItemsAction {}
