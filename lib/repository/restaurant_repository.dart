import 'dart:math';
import '../core/app_exception.dart';
import '../core/mock_helpers.dart';
import '../models/paged.dart';
import 'mock_restaurant_data.dart';
import '../models/restaurant.dart';
 
abstract class RestaurantRepository {
  /// GET /restaurants?page=&limit=&search=&cuisine=
  Future<Paged<Restaurant>> getRestaurants({
    int page = 1,
    int limit = 20,
    String? search,
    String? cuisine,
  });
 
  /// GET /restaurants/{id}
  Future<Restaurant> getRestaurant(int id);
 
  /// GET /restaurants/{id}/menu
  Future<RestaurantMenu> getMenu(int restaurantId);
}
 
class MockRestaurantRepository implements RestaurantRepository {
  @override
  Future<Paged<Restaurant>> getRestaurants({
    int page = 1,
    int limit = 20,
    String? search,
    String? cuisine,
  }) async {
    await mockDelay();
    MockConfig.maybeFail();
 
    final query = search?.trim().toLowerCase() ?? '';
    final all = mockRestaurantsJson
        .map(Restaurant.fromJson)
        .where((r) {
          final matchesSearch = query.isEmpty ||
              r.name.toLowerCase().contains(query) ||
              r.cuisines.any((c) => c.toLowerCase().contains(query));
          final matchesCuisine = cuisine == null ||
              r.cuisines.any((c) => c.toLowerCase() == cuisine.toLowerCase());
          return matchesSearch && matchesCuisine;
        })
        .toList();
 
    final start = (page - 1) * limit;
    final items = start >= all.length
        ? <Restaurant>[]
        : all.sublist(start, min(start + limit, all.length));
 
    return Paged(
      items: items,
      page: page,
      totalPages: max(1, (all.length / limit).ceil()),
    );
  }
 
  @override
  Future<Restaurant> getRestaurant(int id) async {
    await mockDelay(400);
    MockConfig.maybeFail();
    final json = mockRestaurantsJson.where((r) => r['id'] == id);
    if (json.isEmpty) {
      throw const AppException('not_found', 'Restaurant not found', statusCode: 404);
    }
    return Restaurant.fromJson(json.first);
  }
 
  @override
  Future<RestaurantMenu> getMenu(int restaurantId) async {
    await mockDelay();
    MockConfig.maybeFail();
    final json = mockMenusJson[restaurantId];
    if (json == null) {
      throw const AppException('not_found', 'Menu not found', statusCode: 404);
    }
    return RestaurantMenu.fromJson(json);
  }
}