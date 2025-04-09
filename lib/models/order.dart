import 'package:flutter/material.dart';
import 'food_item.dart';

enum OrderStatus { preparing, onTheWay, delivered, cancelled }

class CartItem {
  final FoodItem foodItem;
  int quantity;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
  });

  double get totalPrice => foodItem.price * quantity;
}

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime orderDate;
  final OrderStatus status;
  final double deliveryFee;

  Order({
    required this.id,
    required this.items,
    required this.orderDate,
    this.status = OrderStatus.preparing,
    this.deliveryFee = 0,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal + deliveryFee;

  String get statusString {
    switch (status) {
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.onTheWay:
        return 'On the way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.preparing:
        return Colors.blue;
      case OrderStatus.onTheWay:
        return Colors.orange;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}

// Sample orders for demonstration
List<Order> sampleOrders = [
  Order(
    id: 'ORD-001',
    items: [
      CartItem(foodItem: sampleFoodItems[0], quantity: 2),
      CartItem(foodItem: sampleFoodItems[2], quantity: 1),
    ],
    orderDate: DateTime.now().subtract(const Duration(days: 1)),
    status: OrderStatus.delivered,
  ),
  Order(
    id: 'ORD-002',
    items: [
      CartItem(foodItem: sampleFoodItems[3], quantity: 1),
      CartItem(foodItem: sampleFoodItems[5], quantity: 2),
    ],
    orderDate: DateTime.now().subtract(const Duration(hours: 5)),
    status: OrderStatus.onTheWay,
  ),
  Order(
    id: 'ORD-003',
    items: [
      CartItem(foodItem: sampleFoodItems[1], quantity: 3),
    ],
    orderDate: DateTime.now().subtract(const Duration(hours: 1)),
    status: OrderStatus.preparing,
  ),
];
