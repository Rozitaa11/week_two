import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimatedListDetailScreen extends StatelessWidget {
  const AnimatedListDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(10, (index) => 'Item ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('Animated List')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: 'item-$index',
              child: Container(
                width: 50,
                height: 50,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(child: Text('${index + 1}')),
              ),
            ),
            title: Text(items[index]),
            onTap: () => context.go('/item-detail/$index'),
          );
        },
      ),
    );
  }
}

class ItemDetailScreen extends StatefulWidget {
  final int index;

  const ItemDetailScreen({super.key, required this.index});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail for Item ${widget.index + 1}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'item-${widget.index}',
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: _isExpanded ? 200 : 100,
                height: _isExpanded ? 200 : 100,
                color: Colors.primaries[widget.index % Colors.primaries.length],
                child: Center(child: Text('${widget.index + 1}')),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              child: const Text('Animate'),
            ),
          ],
        ),
      ),
    );
  }
}
