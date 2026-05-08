import '../../core/network/network_info.dart';
import '../../domain/entities/shipment.dart';
import '../../domain/repositories/shipment_repository.dart';
import '../datasources/shipment_local_datasource.dart';
import '../datasources/shipment_remote_datasource.dart';

class ShipmentRepositoryImpl implements ShipmentRepository {
  final ShipmentRemoteDataSource remote;
  final ShipmentLocalDataSource local;
  final NetworkInfo networkInfo;

  ShipmentRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<List<Shipment>> getShipments() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteData = await remote.fetchShipments();

        if (remoteData.isNotEmpty) {
          await local.cacheShipments(remoteData);
        }

        return remoteData;
      } else {
        final cached = await local.getCachedShipments();

        if (cached.isNotEmpty) {
          return cached;
        } else {
          throw Exception("No cached data");
        }
      }
    } catch (_) {
      final cached = await local.getCachedShipments();
      return cached;
    }
  }
}
