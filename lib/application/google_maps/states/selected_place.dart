import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/google_maps/place_detail.dart';

final selectedPlaceProvider = StateProvider<PlaceDetail?>((ref) => null);
