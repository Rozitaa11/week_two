import 'package:flutter/material.dart';

enum ListState { loading, empty, error, loaded }

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  ListState _state = ListState.loaded;
  final List<String> _items = List.generate(20, (index) => 'Item ${index + 1}');

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_items[index]),
          onTap: () {
            // For Hero, but later
          },
        );
      },
    );
  }

  Widget _buildSlivers() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(title: const Text('Slivers Demo'), floating: true),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(title: Text('Sliver Item ${index + 1}'));
          }, childCount: 10),
        ),
      ],
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case ListState.loading:
        return const Center(child: CircularProgressIndicator());
      case ListState.empty:
        return const Center(child: Text('No items available'));
      case ListState.error:
        return const Center(child: Text('Error loading items'));
      case ListState.loaded:
        return _buildListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lists Demo')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _state = ListState.loading),
                child: const Text('Loading'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _state = ListState.empty),
                child: const Text('Empty'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _state = ListState.error),
                child: const Text('Error'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _state = ListState.loaded),
                child: const Text('Loaded'),
              ),
            ],
          ),
          Expanded(child: _buildContent()),
          const Divider(),
          Expanded(child: _buildSlivers()),
        ],
      ),
    );
  }
}
