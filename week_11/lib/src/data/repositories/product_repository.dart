import '../models/product_model.dart';
import '../providers/api_client.dart';
import '../../core/errors/exceptions.dart';

class ProductRepository {
  final ApiClient apiClient;

  ProductRepository(this.apiClient);

  Future<List<ProductModel>> fetchProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await apiClient.get(
        "/products",
        query: {"limit": limit},
      );

      final data = response.data as List;

      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw e is AppException
          ? e
          : AppException("Unexpected error fetching products");
    }
  }
}
