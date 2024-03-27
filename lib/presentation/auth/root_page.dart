import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/auth/register_anonymous_user_usecase.dart';
import '../../domain/repository/shop_item_repository.dart';
import '../../infrastructure/firebase/auth_repository.dart';
import '../../infrastructure/firebase/mock/mock_shop_item_repository.dart';
import '../google_maps/maps_view_dx_page.dart';

final rootPageKey = Provider((ref) => GlobalKey<NavigatorState>());

class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ref.read(registerAnonymousUserUsecaseProvider).execute();
        });
        return;
      },
      [],
    );

    return Scaffold(
      key: ref.watch(rootPageKey),
      body: AuthDependentBuilder(
        onAuthenticated: (userId) {
          return ItemMapPage(
            // todo:現在はデモ用に仮で id を指定している
            // また、デモ用なので Interface の実態が Mock であることは確定している
            item:
                (ref.read(shopItemRepositoryProvider) as MockShopItemRepository)
                    .shopItems
                    .firstWhere((element) => element.id == 'bag_5'),
          );
        },
        onUnAuthenticated: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

/// Firebase に Auth にサインイン済みの場合にのみ [onAuthenticated] で渡した
/// ウィジェットを表示する。
/// その際、サインイン済みのユーザーの `userId` が使用できる。
class AuthDependentBuilder extends ConsumerWidget {
  const AuthDependentBuilder({
    super.key,
    required this.onAuthenticated,
    required this.onUnAuthenticated,
  });

  /// Firebase Auth にサインイン済みの場合に表示されるウィジェットを `userId` とともに
  /// 返すビルダー関数。
  final Widget Function(String userId) onAuthenticated;

  /// Firebase Auth にサインインしていない場合に表示されるウィジェットを返すビルダー関数（任意）
  final Widget Function() onUnAuthenticated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      return onUnAuthenticated();
    }
    return onAuthenticated(userId);
  }
}
