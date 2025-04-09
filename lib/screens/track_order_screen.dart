import 'package:flutter/material.dart';
import '../models/order.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For demo purposes, we'll show tracking for the most recent order
    final currentOrder = sampleOrders.last;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        backgroundColor: const Color(0xFFFEEB50),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${currentOrder.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: currentOrder.statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            currentOrder.statusString,
                            style: TextStyle(
                              color: currentOrder.statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Estimated Delivery: 30-45 min',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tracking status
            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Step indicators
            _buildTrackingStep(
                'Order Placed', 'Your order has been received', true, true),
            _buildTrackingStep('Preparing', 'Your food is being prepared',
                currentOrder.status != OrderStatus.preparing, true),
            _buildTrackingStep(
                'On the Way',
                'Your order is on the way',
                currentOrder.status == OrderStatus.onTheWay ||
                    currentOrder.status == OrderStatus.delivered,
                currentOrder.status != OrderStatus.preparing),
            _buildTrackingStep('Delivered', 'Enjoy your meal!',
                currentOrder.status == OrderStatus.delivered, false),

            const SizedBox(height: 24),

            // Delivery details
            const Text(
              'Delivery Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Map placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('Map View'),
              ),
            ),

            const SizedBox(height: 16),

            // Delivery person info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Juan Dela Cruz',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Delivery Person',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone, color: Colors.green),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.message, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(
      String title, String subtitle, bool isCompleted, bool showConnector) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
            if (showConnector)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? Colors.green : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
