import 'package:flutter/material.dart';
import 'package:retail_dx/presentation/google_maps/maps_view_page.dart';

import '../google_maps/maps_view_dx_page.dart';

class SelectAppPage extends StatelessWidget {
  const SelectAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const MapsViewPage();
                  },
                ),
              );
            },
            child: const Text('リテールテック JAPAN 2024'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ItemListPage();
                    },
                  ),
                );
              },
              child: const Text('リテール DX'),
            ),
          ),
        ],
      ),
    );
  }
}
