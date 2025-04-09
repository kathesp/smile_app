import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/order.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double deliveryFee = 0;

  double get total => subtotal + deliveryFee;

  // Add item to cart
  void addItem(FoodItem foodItem) {
    final existingIndex =
        _items.indexWhere((item) => item.foodItem.id == foodItem.id);

    if (existingIndex >= 0) {
      // Item already exists, increase quantity
      _items[existingIndex].quantity++;
    } else {
      // Add new item
      _items.add(CartItem(foodItem: foodItem));
    }

    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String foodItemId) {
    _items.removeWhere((item) => item.foodItem.id == foodItemId);
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(String foodItemId) {
    final index = _items.indexWhere((item) => item.foodItem.id == foodItemId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(String foodItemId) {
    final index = _items.indexWhere((item) => item.foodItem.id == foodItemId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Clear cart
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Create order from cart items
  Order createOrder() {
    if (_items.isEmpty) {
      throw Exception('Cannot create order with empty cart');
    }

    final order = Order(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}',
      items: List.from(_items),
      orderDate: DateTime.now(),
      deliveryFee: deliveryFee,
    );

    return order;
  }
}
