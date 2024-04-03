import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../domain/shop_item.dart';
import 'maps_view_dx_page.dart';

class SidePanel extends ConsumerWidget {
  const SidePanel({super.key, required this.item});
  final ShopItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PointerInterceptor(
      child: Positioned(
        top: 35,
        bottom: 0,
        left: 35,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(isShowListStateProvider.notifier)
                        .update((_) => true),
                    child: Text('Show list'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Button color
                      onPrimary: Colors.white, // Text color
                    ),
                  ),
                  // Here you can add more UI elements as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
