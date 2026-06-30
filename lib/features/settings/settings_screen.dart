import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CupertinoListSection.insetGrouped(
                header: const Text('Account'),
                children: [
                  authState.when(
                    data: (user) => CupertinoListTile(
                      title: Text(user?.displayName ?? 'Not signed in'),
                      subtitle: Text(user?.email ?? 'Sign in to sync with Google Drive'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () {
                        if (user == null) {
                          ref.read(authServiceProvider.notifier).signIn();
                        } else {
                          ref.read(authServiceProvider.notifier).signOut();
                        }
                      },
                    ),
                    loading: () => const CupertinoListTile(title: CupertinoActivityIndicator()),
                    error: (e, _) => CupertinoListTile(title: Text('Error: $e')),
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                header: const Text('General'),
                children: [
                  CupertinoListTile(
                    title: const Text('Appearance'),
                    trailing: const Text('System'),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    title: const Text('Biometric Lock'),
                    trailing: CupertinoSwitch(value: false, onChanged: (v) {}),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
