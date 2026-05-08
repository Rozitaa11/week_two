import '../models/shipment_model.dart';

class ShipmentRemoteDataSource {
  Future<List<ShipmentModel>> fetchShipments() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ShipmentModel(
        id: "1",
        status: "In Transit",
        timeline: ["Ordered", "Shipped", "In Transit"],
      ),
      ShipmentModel(
        id: "2",
        status: "Delivered",
        timeline: ["Ordered", "Shipped", "Delivered"],
      ),
    ];
  }
}
