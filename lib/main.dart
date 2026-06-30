import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/navigation/navigation_provider.dart';
import 'theme/app_theme.dart';
import 'services/quick_actions_service.dart';
import 'services/link_handler_service.dart';
import 'services/biometric_service.dart';
import 'services/sync_service.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ClipVaultApp(),
    ),
  );
}

class ClipVaultApp extends ConsumerStatefulWidget {
  const ClipVaultApp({super.key});

  @override
  ConsumerState<ClipVaultApp> createState() => _ClipVaultAppState();
}

class _ClipVaultAppState extends ConsumerState<ClipVaultApp> with WidgetsBindingObserver {
  bool _isInactive = false;
  bool _isLocked = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkInitialLock();
  }

  Future<void> _checkInitialLock() async {
    final enabled = await ref.read(biometricServiceProvider.future);
    if (enabled != true) {
      setState(() => _isLocked = false);
      return;
    }
    
    final success = await ref.read(biometricServiceProvider.notifier).authenticate();
    if (success) {
      setState(() => _isLocked = false);
    }
  }
// ...
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _isInactive = state == AppLifecycleState.inactive || state == AppLifecycleState.paused;
    });
    
    if (state == AppLifecycleState.resumed) {
      ref.read(syncServiceProvider.notifier).sync();
      if (!_isInactive) _checkInitialLock();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    
    // Initialize services
    ref.watch(quickActionsServiceProvider);
    ref.watch(linkHandlerServiceProvider);

    return Stack(
      children: [
        CupertinoApp.router(
          title: 'ClipVault',
          theme: AppTheme.lightTheme,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
        if (_isInactive || _isLocked)
          Positioned.fill(
            child: BlurredOverlay(
              onUnlock: () => setState(() => _isLocked = false),
              showUnlockButton: _isLocked,
            ),
          ),
      ],
    );
  }
}

class BlurredOverlay extends ConsumerWidget {
  final VoidCallback onUnlock;
  final bool showUnlockButton;

  const BlurredOverlay({
    super.key,
    required this.onUnlock,
    required this.showUnlockButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: CupertinoColors.systemBackground.withValues(alpha: 0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(CupertinoIcons.lock_shield, size: 80, color: CupertinoColors.systemBlue),
            if (showUnlockButton) ...[
              const SizedBox(height: 24),
              CupertinoButton.filled(
                child: const Text('Unlock ClipVault'),
                onPressed: () async {
                  final success = await ref.read(biometricServiceProvider.notifier).authenticate();
                  if (success) onUnlock();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
