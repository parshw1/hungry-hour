class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisines,
    this.imageUrl,
    required this.rating,
    required this.deliveryTimeMin,
    required this.deliveryFee,
    required this.minOrder,
    required this.isOpen,
    this.description,
    this.address,
    this.openingHours,
  });
 
  final int id; // change to String if the backend uses UUIDs
  final String name;
  final List<String> cuisines;
  final String? imageUrl; // can be missing, show a placeholder
  final double rating;
  final int deliveryTimeMin;
  final int deliveryFee; // smallest currency unit
  final int minOrder; // smallest currency unit
  final bool isOpen;
 
  final String? description;
  final String? address;
  final String? openingHours;
 
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'] as int,
        name: json['name'] as String,
        cuisines: (json['cuisines'] as List<dynamic>? ?? const [])
            .map((e) => e as String)
            .toList(),
        imageUrl: json['image_url'] as String?,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        deliveryTimeMin: json['delivery_time_min'] as int? ?? 0,
        deliveryFee: json['delivery_fee'] as int? ?? 0,
        minOrder: json['min_order'] as int? ?? 0,
        isOpen: json['is_open'] as bool? ?? true,
        description: json['description'] as String?,
        address: json['address'] as String?,
        openingHours: json['opening_hours'] as String?,
      );
 
  String get cuisinesText => cuisines.join(', ');
}
 
class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.isVeg,
    required this.isAvailable,
  });
 
  final int id;
  final String name;
  final String? description;
  final int price; // smallest currency unit
  final String? imageUrl;
  final bool isVeg;
  final bool isAvailable;
 
  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String?,
        price: json['price'] as int,
        imageUrl: json['image_url'] as String?,
        isVeg: json['is_veg'] as bool? ?? true,
        isAvailable: json['is_available'] as bool? ?? true,
      );
}
 
class MenuCategory {
  const MenuCategory({
    required this.id,
    required this.name,
    required this.items,
  });
 
  final int id;
  final String name;
  final List<MenuItem> items;
 
  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
        id: json['id'] as int,
        name: json['name'] as String,
        items: (json['items'] as List<dynamic>)
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
 
class RestaurantMenu {
  const RestaurantMenu({required this.restaurantId, required this.categories});
 
  final int restaurantId;
  final List<MenuCategory> categories;
 
  factory RestaurantMenu.fromJson(Map<String, dynamic> json) => RestaurantMenu(
        restaurantId: json['restaurant_id'] as int,
        categories: (json['categories'] as List<dynamic>)
            .map((e) => MenuCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}