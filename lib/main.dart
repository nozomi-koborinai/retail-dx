import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:retail_dx/domain/repository/shop_info_repository.dart';
import 'package:retail_dx/domain/repository/shop_item_repository.dart';
import 'package:retail_dx/infrastructure/firebase/mock/mock_shop_info_repository.dart';
import 'package:retail_dx/infrastructure/firebase/mock/mock_shop_item_repository.dart';
import 'package:retail_dx/presentation/app.dart';

import 'application/google_maps/states/current_map_position.dart';
import 'domain/env.dart';
import 'domain/geo_location.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase の初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // google fontsの設定
  GoogleFonts.config.allowRuntimeFetching = kDebugMode;
  await GoogleFonts.pendingFonts([
    GoogleFonts.sawarabiGothicTextTheme(),
  ]);

  // .env ファイルの読み込み
  await dotenv.load();

  // 位置情報取得権限の設定
  final geoLocation = await _setupGeolocatorPermission();

  // 画面の向きを縦に固定
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // パッケージ情報
  // final packageInfo = await PackageInfo.fromPlatform();

  // アプリケーションの実行
  runApp(
    ProviderScope(
      overrides: [
        // 環境変数を上書き
        envProvider.overrideWithValue(
          Env(
            googleMapsApiKey: dotenv.get('GOOGLE_MAPS_API_KEY'),
            weatherApiKey: dotenv.get('WEATHER_API_KEY'),
          ),
        ),

        // Google Maps 位置情報を上書き
        currentMapPositionProvider.overrideWith(
          (_) {
            if (geoLocation == null) {
              // 端末の位置情報が許可されていない場合、東京都庁の位置情報を返す
              return const LatLng(35.689487, 139.691706);
            }

            return LatLng(geoLocation.latitude, geoLocation.longitude);
          },
        ),

        // Repository の上書き
        shopItemRepositoryProvider.overrideWithValue(MockShopItemRepository()),
        shopInfoRepositoryProvider.overrideWithValue(MockShopInfoRepository()),

        // アプリ情報の上書き
        // appInfoProvider.overrideWith(
        //   (ref) => AppInfo(
        //     appName: packageInfo.appName,
        //     packageName: packageInfo.packageName,
        //     version: 'v${packageInfo.version}',
        //     buildNumber: packageInfo.buildNumber,
        //     copyRight: '(C)2024 Cloud Ace, Inc.',
        //     iconImagePath: '',
        //     privacyPolicyUrl: Uri.parse(''),
        //     termsOfServiceUrl: Uri.parse(''),
        //   ),
        // ),
      ],
      child: const App(),
    ),
  );
}

Future<GeoLocation?> _setupGeolocatorPermission() async {
  // 位置情報サービスが有効かどうか確認する
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // 位置情報サービスが有効でない場合、続行不可
    return null;
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // ユーザーに位置情報を許可してもらうよう促す
    permission = await Geolocator.requestPermission();
  }

  switch (permission) {
    case LocationPermission.denied:
    case LocationPermission.deniedForever:
      return null;

    case LocationPermission.whileInUse:
    case LocationPermission.always:
    case LocationPermission.unableToDetermine:
      // 位置情報に対しての権限が許可されているということなのでデバイスの位置情報を返す
      final position = await Geolocator.getCurrentPosition();
      return GeoLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
  }
}
