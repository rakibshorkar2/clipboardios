import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';
import '../../services/stats_service.dart';
import '../../services/export_service.dart';
import '../../services/sync_service.dart';
import '../../services/biometric_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final statsState = ref.watch(statsServiceProvider);
    final biometricState = ref.watch(biometricServiceProvider);

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
                  if (authState.value != null)
                    CupertinoListTile(
                      title: const Text('Sync Now'),
                      trailing: const Icon(CupertinoIcons.refresh, size: 20),
                      onTap: () => ref.read(syncServiceProvider.notifier).sync(),
                    ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                header: const Text('Security'),
                children: [
                  CupertinoListTile(
                    title: const Text('Biometric Lock'),
                    trailing: CupertinoSwitch(
                      value: biometricState.value ?? false,
                      onChanged: (v) => ref.read(biometricServiceProvider.notifier).setEnabled(v),
                    ),
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                header: const Text('Data Management'),
                children: [
                  CupertinoListTile(
                    title: const Text('Export to JSON'),
                    trailing: const Icon(CupertinoIcons.share, size: 20),
                    onTap: () => ref.read(exportServiceProvider.notifier).exportToJson(),
                  ),
                  CupertinoListTile(
                    title: const Text('Export to CSV'),
                    trailing: const Icon(CupertinoIcons.share, size: 20),
                    onTap: () => ref.read(exportServiceProvider.notifier).exportToCsv(),
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                header: const Text('Statistics'),
                children: [
                  statsState.when(
                    data: (stats) {
                      if (stats.isEmpty) return const CupertinoListTile(title: Text('No data yet'));
                      return Column(
                        children: [
                          CupertinoListTile(
                            title: const Text('Total Saved'),
                            trailing: Text('${stats['totalSaved']}'),
                          ),
                          CupertinoListTile(
                            title: const Text('Most Common Type'),
                            trailing: Text('${stats['mostCommonType']}'.toUpperCase()),
                          ),
                          CupertinoListTile(
                            title: const Text('Favorites'),
                            trailing: Text('${stats['favoritesCount']}'),
                          ),
                        ],
                      );
                    },
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
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
