import 'package:flutter/material.dart';

import 'src/data/providers/api_client.dart';
import 'src/data/repositories/product_repository.dart';
import 'src/data/models/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Module Demo',
      debugShowCheckedModeBanner: false,
      home: const ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductRepository repository;

  final List<ProductModel> products = [];
  final ScrollController scrollController = ScrollController();

  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  String? error;

  @override
  void initState() {
    super.initState();
    repository = ProductRepository(ApiClient());
    fetchProducts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        fetchProducts();
      }
    });
  }

  Future<void> fetchProducts() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final newProducts = await repository.fetchProducts(page: page);

      setState(() {
        if (newProducts.isEmpty) {
          hasMore = false;
        } else {
          page++;
          products.addAll(newProducts);
        }
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> retry() async {
    await fetchProducts();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty && isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error != null && products.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error!),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: retry, child: const Text("Retry")),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ListView.builder(
        controller: scrollController,
        itemCount: products.length + 1,
        itemBuilder: (context, index) {
          if (index < products.length) {
            final product = products[index];

            return ListTile(
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.title),
              subtitle: Text("\$${product.price}"),
            );
          } else {
            if (isLoading) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (!hasMore) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text("No more products")),
              );
            } else {
              return const SizedBox();
            }
          }
        },
      ),
    );
  }
}
