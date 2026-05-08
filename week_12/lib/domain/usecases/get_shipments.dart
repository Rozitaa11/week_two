import '../entities/shipment.dart';
import '../repositories/shipment_repository.dart';

class GetShipments {
  final ShipmentRepository repository;

  GetShipments(this.repository);

  Future<List<Shipment>> call() async {
    return await repository.getShipments();
  }
}
