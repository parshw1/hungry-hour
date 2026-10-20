import 'dart:math';
 
import '../core/app_exception.dart';
import '../core/mock_helpers.dart';
import '../models/paged.dart';
import 'address_repository.dart';
import 'mock_restaurant_data.dart';
import '../models/order.dart';
 
abstract class OrderRepository {
  
  Future<Order> placeOrder(CreateOrderRequest request);
 
  
  Future<Paged<OrderSummary>> getOrders({int page = 1, int limit = 20});
 
  
  Future<Order> getOrder(int id);
 
  
  Future<Order> cancelOrder(int id);
}
 
class MockOrderRepository implements OrderRepository {
  MockOrderRepository(this._addresses);
 
  final AddressRepository _addresses;
  final List<Order> _orders = [];
  final Set<int> _cancelled = {};
  int _nextId = 9001;
 
  OrderStatus _statusFor(Order order) {
    if (_cancelled.contains(order.id)) return OrderStatus.cancelled;
    final seconds = DateTime.now().difference(order.createdAt).inSeconds;
    if (seconds < 15) return OrderStatus.pending;
    if (seconds < 30) return OrderStatus.confirmed;
    if (seconds < 60) return OrderStatus.preparing;
    if (seconds < 90) return OrderStatus.outForDelivery;
    return OrderStatus.delivered;
  }
 
  Order _live(Order order) => order.copyWith(status: _statusFor(order));
 
  @override
  Future<Order> placeOrder(CreateOrderRequest request) async {
    await mockDelay(900);
    MockConfig.maybeFail();
 
    if (request.items.isEmpty) {
      throw const AppException(
        'validation_error',
        'Your cart is empty',
        statusCode: 422,
      );
    }
 
    final restaurant = mockRestaurantsJson.firstWhere(
      (r) => r['id'] == request.restaurantId,
      orElse: () => throw const AppException('not_found', 'Restaurant not found', statusCode: 404),
    );
    if (restaurant['is_open'] == false) {
      throw const AppException('restaurant_closed', 'This restaurant is closed', statusCode: 409);
    }
    if (request.items.any((c) => !c.menuItem.isAvailable)) {
      throw const AppException('item_unavailable', 'An item is no longer available', statusCode: 409);
    }
 
    final addresses = await _addresses.getAddresses();
    final address = addresses.firstWhere(
      (a) => a.id == request.addressId,
      orElse: () => throw const AppException('not_found', 'Address not found', statusCode: 404),
    );
 
    final lines = request.items
        .map((c) => OrderLine(
              menuItemId: c.menuItem.id,
              name: c.menuItem.name,
              quantity: c.quantity,
              unitPrice: c.menuItem.price,
            ))
        .toList();
    final subtotal = lines.fold<int>(0, (sum, l) => sum + l.lineTotal);
    final deliveryFee = restaurant['delivery_fee'] as int;
    final now = DateTime.now();
 
    final order = Order(
      id: _nextId++,
      status: OrderStatus.pending,
      restaurantId: request.restaurantId,
      restaurantName: restaurant['name'] as String,
      items: lines,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: subtotal + deliveryFee,
      paymentMethod: request.paymentMethod,
      address: OrderAddress(
        line1: address.line1,
        city: address.city,
        pincode: address.pincode,
      ),
      createdAt: now,
      estimatedDeliveryAt:
          now.add(Duration(minutes: restaurant['delivery_time_min'] as int)),
      note: request.note,
    );
    _orders.add(order);
    return order;
  }
 
  @override
  Future<Paged<OrderSummary>> getOrders({int page = 1, int limit = 20}) async {
    await mockDelay();
    MockConfig.maybeFail();
 
    final newestFirst = _orders.reversed.map(_live).toList();
    final start = (page - 1) * limit;
    final items = start >= newestFirst.length
        ? <OrderSummary>[]
        : newestFirst
            .sublist(start, min(start + limit, newestFirst.length))
            .map((o) => o.toSummary())
            .toList();
 
    return Paged(
      items: items,
      page: page,
      totalPages: max(1, (newestFirst.length / limit).ceil()),
    );
  }
 
  @override
  Future<Order> getOrder(int id) async {
    await mockDelay(300);
    MockConfig.maybeFail();
    final order = _orders.where((o) => o.id == id);
    if (order.isEmpty) {
      throw const AppException('not_found', 'Order not found', statusCode: 404);
    }
    return _live(order.first);
  }
 
  @override
  Future<Order> cancelOrder(int id) async {
    await mockDelay();
    MockConfig.maybeFail();
    final order = await getOrder(id);
    if (order.status.isFinal) {
      throw const AppException('bad_request', 'This order can no longer be cancelled', statusCode: 400);
    }
    _cancelled.add(id);
    return order.copyWith(status: OrderStatus.cancelled);
  }
}