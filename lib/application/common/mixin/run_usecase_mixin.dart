import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/app_exception.dart';
import '../state/overlay_loading_provider.dart';

/// ユースケース実行のためのメソッドを備えた Mixin
mixin RunUsecaseMixin {
  Future<T> run<T>(
    Ref ref,
    Future<T> Function() action, {
    bool isLottieAnimation = false,
    bool isExecuteLoading = true,
  }) async {
    final notifier = isLottieAnimation
        ? ref.read(overlayLottieProvider.notifier)
        : ref.read(overlayLoadingProvider.notifier);
    if (isExecuteLoading) notifier.update((_) => true);
    try {
      return await action();
    } catch (e) {
      if (e is AppException) {
        rethrow;
      } else {
        throw AppException(e.toString());
      }
    } finally {
      notifier.update((_) => false);
    }
  }
}
