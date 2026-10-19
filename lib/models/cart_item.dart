import '../models/restaurant.dart';
 
/// Cart lives inside the app until checkout (no cart endpoints in the contract).
class CartItem {
  const CartItem({
    required this.menuItem,
    required this.restaurantId,
    required this.quantity,
  });
 
  final MenuItem menuItem;
  final int restaurantId;
  final int quantity;
 
  int get lineTotal => menuItem.price * quantity;
 
  CartItem copyWith({int? quantity}) => CartItem(
        menuItem: menuItem,
        restaurantId: restaurantId,
        quantity: quantity ?? this.quantity,
      );
 
  /// What POST /orders expects (no prices, the server calculates them).
  Map<String, dynamic> toOrderLineJson() => {
        'menu_item_id': menuItem.id,
        'quantity': quantity,
      };
}