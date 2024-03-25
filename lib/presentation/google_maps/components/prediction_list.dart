import 'package:flutter/material.dart';

import '../../../domain/google_maps/predictions.dart';

class PredictionList extends StatelessWidget {
  final List<Prediction> predictions;
  final void Function(Prediction) onPredictionSelected;

  const PredictionList({
    Key? key,
    required this.predictions,
    required this.onPredictionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: predictions.length,
      itemBuilder: (context, index) {
        final prediction = predictions[index];
        return Card(
          elevation: 4.0,
          surfaceTintColor: Colors.white,
          color: Colors.white.withOpacity(0.9),
          child: ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(prediction.description),
            onTap: () => onPredictionSelected(prediction),
          ),
        );
      },
    );
  }
}
