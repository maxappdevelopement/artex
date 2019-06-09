import './art.dart';
import 'package:artex/redux/actions.dart';
import 'package:redux/redux.dart';


class ViewModel {
  final List<Item> items;
  final Function(Item) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onAddItem(Item item) {
      store.dispatch(AddItemAction(item));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    return ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
    );
  }
}