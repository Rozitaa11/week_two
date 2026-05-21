import '../models/order_model.dart';
import '../providers/api_client.dart';
import '../../core/errors/exceptions.dart';

class OrderRepository {
  final ApiClient apiClient;

  OrderRepository(this.apiClient);

  Future<List<OrderModel>> fetchOrders() async {
    try {
      final response = await apiClient.get("/carts");

      final data = response.data as List;

      return data.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw e is AppException
          ? e
          : AppException("Unexpected error fetching orders");
    }
  }
}
