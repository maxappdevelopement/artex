import 'package:artex/models/art.dart';
import 'package:artex/redux/actions.dart';


AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
  );
}

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    print(action.id);
    return []
      ..addAll(state)
      ..add(Item.withId(id: action.id, 
      title: action.item.title,
      description: action.item.description,
      price: action.item.price,
      date: action.item.date,
      ));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return List.unmodifiable([]);
  }

  return state;
}

