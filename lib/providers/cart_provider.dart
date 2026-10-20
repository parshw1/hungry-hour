import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../models/restaurant.dart';
import '../models/cart_item.dart';
 
class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];
 
  int? get restaurantId => state.isEmpty ? null : state.first.restaurantId;
 
  bool add(MenuItem item, int restaurantId) {
    if (state.isNotEmpty && this.restaurantId != restaurantId) return false;
 
    final index = state.indexWhere((c) => c.menuItem.id == item.id);
    if (index == -1) {
      state = [
        ...state,
        CartItem(menuItem: item, restaurantId: restaurantId, quantity: 1),
      ];
    } else {
      setQuantity(item.id, state[index].quantity + 1);
    }
    return true;
  }
 
  void setQuantity(int menuItemId, int quantity) {
    if (quantity <= 0) {
      remove(menuItemId);
      return;
    }
    state = [
      for (final c in state)
        if (c.menuItem.id == menuItemId) c.copyWith(quantity: quantity) else c,
    ];
  }
 
  void remove(int menuItemId) {
    state = state.where((c) => c.menuItem.id != menuItemId).toList();
  }
 
  void clear() => state = [];
}
 
final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);
 
final cartSubtotalProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, c) => sum + c.lineTotal);
});
 
final cartCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, c) => sum + c.quantity);
});