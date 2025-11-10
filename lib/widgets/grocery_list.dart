import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
      'flutter-shop-b6eb7-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to load items. Please try again later.');
    }

    if (response.body == 'null') {
      return [];
    }

    final listData = json.decode(response.body) as Map<String, dynamic>;
    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final value = item.value as Map<String, dynamic>;

      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == value['category'] as String,
          )
          .value;

      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: value['name'] as String,
          quantity: value['quantity'] as int,
          category: category,
        ),
      );
    }

    return loadedItems;
  }

  Future<void> _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  Future<void> _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-shop-b6eb7-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });

      if (!context.mounted) {
        return;
      }

      await showDialog<void>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Deletion failed'),
          content: const Text(
            'Deletion failed. Please try again later.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items added yet'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(snapshot.data![index].id),
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: snapshot.data![index].category.color,
                ),
                trailing: Text(snapshot.data![index].quantity.toString()),
              ),
              onDismissed: (direction) {
                _removeItem(snapshot.data![index]);
              },
            ),
          );
        },
      ),
    );
  }
}
