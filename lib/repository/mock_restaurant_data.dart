Map<String, dynamic> _item(
  int id,
  String name,
  String description,
  int price, {
  bool veg = true,
  bool available = true,
}) =>
    {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': 'https://picsum.photos/seed/item$id/300/300',
      'is_veg': veg,
      'is_available': available,
    };
 
Map<String, dynamic> _category(int id, String name, List<Map<String, dynamic>> items) =>
    {'id': id, 'name': name, 'items': items};
 
Map<String, dynamic> _menu(int restaurantId, List<Map<String, dynamic>> categories) =>
    {'restaurant_id': restaurantId, 'categories': categories};
 
final List<Map<String, dynamic>> mockRestaurantsJson = [
  {
    'id': 1,
    'name': 'Pizza Palace',
    'cuisines': ['Pizza', 'Italian'],
    'image_url': 'https://picsum.photos/seed/pizza/600/400',
    'rating': 4.5,
    'delivery_time_min': 30,
    'delivery_fee': 4000,
    'min_order': 15000,
    'is_open': true,
    'description': 'Wood-fired pizzas since 2010',
    'address': '45 Civil Lines',
    'opening_hours': '10:00-23:00',
  },
  {
    'id': 2,
    'name': 'Burger Barn',
    'cuisines': ['Burgers', 'American'],
    'image_url': 'https://picsum.photos/seed/burger/600/400',
    'rating': 4.1,
    'delivery_time_min': 25,
    'delivery_fee': 3000,
    'min_order': 12000,
    'is_open': true,
    'description': 'Smashed patties and thick shakes',
    'address': '8 Market Road',
    'opening_hours': '11:00-00:00',
  },
  {
    'id': 3,
    'name': 'Dosa Corner',
    'cuisines': ['South Indian', 'Vegetarian'],
    'image_url': 'https://picsum.photos/seed/dosa/600/400',
    'rating': 4.7,
    'delivery_time_min': 35,
    'delivery_fee': 2500,
    'min_order': 8000,
    'is_open': true,
    'description': 'Crispy dosas and fresh chutneys',
    'address': '3 Temple Street',
    'opening_hours': '07:00-22:00',
  },
  {
    'id': 4,
    'name': 'Sushi Zen',
    'cuisines': ['Japanese', 'Sushi'],
    'image_url': 'https://picsum.photos/seed/sushi/600/400',
    'rating': 4.3,
    'delivery_time_min': 40,
    'delivery_fee': 5000,
    'min_order': 25000,
    'is_open': false, // closed: test your "closed" UI
    'description': 'Hand-rolled sushi, made to order',
    'address': '21 Lake View',
    'opening_hours': '12:00-22:00',
  },
  {
    'id': 5,
    'name': 'Spice Route: a restaurant with a very long name to test text overflow',
    'cuisines': ['Indian', 'North Indian', 'Mughlai'],
    'image_url': 'https://picsum.photos/seed/spice/600/400',
    'rating': 4.4,
    'delivery_time_min': 45,
    'delivery_fee': 3500,
    'min_order': 20000,
    'is_open': true,
    'description': 'Slow-cooked curries and fresh breads',
    'address': '17 Old Bazaar',
    'opening_hours': '11:00-23:30',
  },
  {
    'id': 6,
    'name': 'Green Bowl',
    'cuisines': ['Healthy', 'Salads'],
    'image_url': null, // no image: test your placeholder
    'rating': 4.0,
    'delivery_time_min': 20,
    'delivery_fee': 2000,
    'min_order': 10000,
    'is_open': true,
    'description': 'Bowls, salads and smoothies',
    'address': '5 Park Avenue',
    'opening_hours': '09:00-21:00',
  },
];
 
final Map<int, Map<String, dynamic>> mockMenusJson = {
  1: _menu(1, [
    _category(1, 'Pizzas', [
      _item(101, 'Margherita', 'Tomato, mozzarella, basil', 24900),
      _item(102, 'Pepperoni', 'Spicy pepperoni, mozzarella', 29900, veg: false),
      _item(103, 'Farmhouse', 'Capsicum, onion, mushroom, olives', 31900),
    ]),
    _category(2, 'Sides & Drinks', [
      _item(104, 'Garlic Bread', 'Toasted with garlic butter', 14900),
      _item(105, 'Cola', '330 ml can', 6000),
    ]),
  ]),
  2: _menu(2, [
    _category(1, 'Burgers', [
      _item(201, 'Classic Beef', 'Beef patty, cheese, pickles', 19900, veg: false),
      _item(202, 'Crispy Chicken', 'Fried chicken, slaw, mayo', 18900, veg: false),
      _item(203, 'Veggie Delight', 'Crispy veg patty, lettuce, tomato', 15900),
    ]),
    _category(2, 'Sides & Shakes', [
      _item(204, 'Fries', 'Salted, crispy', 9900),
      _item(205, 'Chocolate Shake', 'Thick and cold', 12900, available: false),
    ]),
  ]),
  3: _menu(3, [
    _category(1, 'Dosas', [
      _item(301, 'Masala Dosa', 'Potato filling, chutneys, sambar', 12000),
      _item(302, 'Mysore Dosa', 'Spicy red chutney spread', 13500),
      _item(303, 'Rava Dosa', 'Crispy semolina dosa', 12500),
    ]),
    _category(2, 'Drinks', [
      _item(304, 'Filter Coffee', 'South Indian style', 5000),
    ]),
  ]),
  4: _menu(4, [
    _category(1, 'Rolls', [
      _item(401, 'California Roll', 'Crab, avocado, cucumber', 34900, veg: false),
      _item(402, 'Veg Maki', 'Cucumber, carrot, avocado', 24900),
    ]),
    _category(2, 'Mains', [
      _item(403, 'Chicken Katsu', 'Crumbed chicken with rice', 38900, veg: false),
    ]),
  ]),
  5: _menu(5, [
    _category(1, 'Curries', [
      _item(501, 'Butter Chicken', 'Creamy tomato gravy', 32900, veg: false),
      _item(502, 'Paneer Tikka Masala', 'Grilled paneer in masala', 28900),
      _item(503, 'Dal Makhani', 'Slow-cooked black lentils', 22900),
    ]),
    _category(2, 'Breads', [
      _item(504, 'Garlic Naan', 'Tandoor baked', 5500),
    ]),
  ]),
  6: _menu(6, [
    _category(1, 'Bowls & Salads', [
      _item(601, 'Quinoa Power Bowl', 'Quinoa, chickpeas, greens', 22000),
      _item(602, 'Caesar Salad', 'Romaine, parmesan, croutons', 19000),
    ]),
    _category(2, 'Smoothies', [
      _item(603, 'Mango Smoothie', 'Fresh mango and yogurt', 11000),
    ]),
  ]),
};