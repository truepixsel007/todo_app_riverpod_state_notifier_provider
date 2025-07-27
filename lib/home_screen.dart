import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'item_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Crud App')),
      body:
          item.isEmpty
              ? const Center(child: Text('No Data Found'))
              : ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  final itemDetail = item[index];
                  return ListTile(
                    title: Text(itemDetail.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            ref
                                .read(itemProvider.notifier)
                                .updateItem(itemDetail.id, 'Updated item');
                          },
                          icon: Icon(Icons.edit),
                        ),

                        IconButton(
                          onPressed: () {
                            ref
                                .read(itemProvider.notifier)
                                .deleteItem(itemDetail.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(itemProvider.notifier).addItem('New Item');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
