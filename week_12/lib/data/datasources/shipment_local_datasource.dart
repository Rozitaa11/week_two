import 'package:hive/hive.dart';
import '../models/shipment_model.dart';

class ShipmentLocalDataSource {
  Future<void> cacheShipments(List<ShipmentModel> shipments) async {
    final box = await Hive.openBox('shipments');

    final data = shipments.map((e) => e.toJson()).toList();
    await box.put('cached', data);
  }

  Future<List<ShipmentModel>> getCachedShipments() async {
    final box = await Hive.openBox('shipments');

    final data = box.get('cached');

    if (data == null) return [];

    return (data as List)
        .map((e) => ShipmentModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
