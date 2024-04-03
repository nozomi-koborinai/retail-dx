// MapDialog.dart
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../domain/shop_info.dart';
import '../../../domain/shop_item.dart';

class MapDialog extends StatelessWidget {
  const MapDialog(
      {super.key, required this.imageUrl, required this.shopItemFusions});
  final String imageUrl;
  final List<(ShopInfo, ShopItem)> shopItemFusions;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0), // 角の丸み
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // 影の位置を調整
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(8.0),
        child: PointerInterceptor(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Pickup today',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your postcode',
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: shopItemFusions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final shop = shopItemFusions[index];
                    return ListTile(
                      title: Text(shop.$1.name),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Handle your curbside pickup logic here
                        },
                        child: Text('Curbside pickup'),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
