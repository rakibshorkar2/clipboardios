import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/navigation/navigation_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ClipVaultApp(),
    ),
  );
}

class ClipVaultApp extends ConsumerWidget {
  const ClipVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return CupertinoApp.router(
      title: 'ClipVault',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
