import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shipment_bloc.dart';
import '../widgets/offline_banner.dart';
import '../widgets/shipment_card.dart';
import 'shipment_detail_page.dart';

class ShipmentsPage extends StatelessWidget {
  final bool isOffline;

  const ShipmentsPage({super.key, required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text("Deliveries"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          OfflineBanner(isOffline: isOffline),
          Expanded(
            child: BlocBuilder<ShipmentBloc, ShipmentState>(
              builder: (context, state) {
                if (state is ShipmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ShipmentLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: state.shipments.length,
                    itemBuilder: (context, index) {
                      final shipment = state.shipments[index];

                      return ShipmentCard(
                        shipment: shipment,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ShipmentDetailPage(shipment: shipment),
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                return const Center(
                  child: Text(
                    "No shipments found",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
