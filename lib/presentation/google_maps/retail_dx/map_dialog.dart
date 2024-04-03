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
    return Dialog(
      surfaceTintColor: Colors.white,
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
                itemCount: shopItemFusions
                    .length, // Replace with your actual store list count
                itemBuilder: (BuildContext context, int index) {
                  // Replace with your actual data model
                  final shop = shopItemFusions[index];
                  return ListTile(
                    title: Text(shop.$1.name),
                    // subtitle: Text(
                    //   '${shop.distance} mi - ${shop.time} min',
                    // ),
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
    );
  }
}
