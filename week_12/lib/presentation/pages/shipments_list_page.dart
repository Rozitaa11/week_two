import 'package:flutter/material.dart';

class ShipmentsListPage extends StatelessWidget {
  final bool isOffline; // This would come from your State Management

  const ShipmentsListPage({super.key, required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Deliveries')),
      body: Column(
        children: [
          if (isOffline)
            Container(
              color: Colors.orange,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Offline Mode: Showing cached data',
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with dynamic data
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.local_shipping),
                title: Text('Shipment #100$index'),
                subtitle: const Text('In Transit'),
                onTap: () => Navigator.pushNamed(context, '/details'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
