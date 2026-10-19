import '../models/cart_item.dart';
 
enum OrderStatus {
  pending('pending'),
  confirmed('confirmed'),
  preparing('preparing'),
  outForDelivery('out_for_delivery'),
  delivered('delivered'),
  cancelled('cancelled');
 
  const OrderStatus(this.apiValue);
  final String apiValue;
 
  static OrderStatus fromApi(String value) => OrderStatus.values.firstWhere(
        (s) => s.apiValue == value,
        orElse: () => OrderStatus.pending, // unknown status: don't crash
      );
 
  String get label => switch (this) {
        OrderStatus.pending => 'Order placed',
        OrderStatus.confirmed => 'Confirmed',
        OrderStatus.preparing => 'Preparing',
        OrderStatus.outForDelivery => 'Out for delivery',
        OrderStatus.delivered => 'Delivered',
        OrderStatus.cancelled => 'Cancelled',
      };
 
  /// Stop polling once an order reaches one of these.
  bool get isFinal =>
      this == OrderStatus.delivered || this == OrderStatus.cancelled;
}
 
class OrderLine {
  const OrderLine({
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
  });
 
  final int menuItemId;
  final String name;
  final int quantity;
  final int unitPrice;
 
  int get lineTotal => unitPrice * quantity;
 
  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
        menuItemId: json['menu_item_id'] as int,
        name: json['name'] as String,
        quantity: json['quantity'] as int,
        unitPrice: json['unit_price'] as int,
      );
}
 
class OrderAddress {
  const OrderAddress({
    required this.line1,
    required this.city,
    required this.pincode,
  });
 
  final String line1;
  final String city;
  final String pincode;
 
  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
        line1: json['line1'] as String,
        city: json['city'] as String,
        pincode: json['pincode'] as String,
      );
 
  String get fullText => '$line1, $city, $pincode';
}
 
/// Full order (POST /orders response and GET /orders/{id}).
class Order {
  const Order({
    required this.id,
    required this.status,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.paymentMethod,
    required this.address,
    required this.createdAt,
    this.estimatedDeliveryAt,
    this.note,
  });
 
  final int id;
  final OrderStatus status;
  final int restaurantId;
  final String restaurantName;
  final List<OrderLine> items;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final String paymentMethod;
  final OrderAddress address;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryAt;
  final String? note;
 
  factory Order.fromJson(Map<String, dynamic> json) {
    final restaurant = json['restaurant'] as Map<String, dynamic>;
    return Order(
      id: json['id'] as int,
      status: OrderStatus.fromApi(json['status'] as String),
      restaurantId: restaurant['id'] as int,
      restaurantName: restaurant['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: json['subtotal'] as int,
      deliveryFee: json['delivery_fee'] as int,
      total: json['total'] as int,
      paymentMethod: json['payment_method'] as String,
      address: OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
      estimatedDeliveryAt: json['estimated_delivery_at'] == null
          ? null
          : DateTime.parse(json['estimated_delivery_at'] as String).toLocal(),
      note: json['note'] as String?,
    );
  }
 
  Order copyWith({OrderStatus? status}) => Order(
        id: id,
        status: status ?? this.status,
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        total: total,
        paymentMethod: paymentMethod,
        address: address,
        createdAt: createdAt,
        estimatedDeliveryAt: estimatedDeliveryAt,
        note: note,
      );
 
  OrderSummary toSummary() => OrderSummary(
        id: id,
        status: status,
        restaurantName: restaurantName,
        total: total,
        itemCount: items.fold(0, (sum, l) => sum + l.quantity),
        createdAt: createdAt,
      );
}
 
/// One row of GET /orders (the history list).
class OrderSummary {
  const OrderSummary({
    required this.id,
    required this.status,
    required this.restaurantName,
    required this.total,
    required this.itemCount,
    required this.createdAt,
  });
 
  final int id;
  final OrderStatus status;
  final String restaurantName;
  final int total;
  final int itemCount;
  final DateTime createdAt;
 
  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        id: json['id'] as int,
        status: OrderStatus.fromApi(json['status'] as String),
        restaurantName: json['restaurant_name'] as String,
        total: json['total'] as int,
        itemCount: json['item_count'] as int,
        createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
      );
}
 
/// Body of POST /orders.
class CreateOrderRequest {
  const CreateOrderRequest({
    required this.restaurantId,
    required this.addressId,
    required this.items,
    this.paymentMethod = 'cod',
    this.note,
  });
 
  final int restaurantId;
  final int addressId;
  final List<CartItem> items;
  final String paymentMethod;
  final String? note;
 
  Map<String, dynamic> toJson() => {
        'restaurant_id': restaurantId,
        'address_id': addressId,
        'payment_method': paymentMethod,
        if (note != null && note!.isNotEmpty) 'note': note,
        'items': items.map((c) => c.toOrderLineJson()).toList(),
      };
}