import '../../domain/entities/shipment.dart';

class ShipmentModel extends Shipment {
  ShipmentModel({
    required super.id,
    required super.status,
    required super.timeline,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      timeline: List<String>.from(json['timeline'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'timeline': timeline,
    };
  }
}
