import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/clipboard_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start clipboard monitoring
    ref.watch(clipboardServiceProvider);
    
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Timeline'),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text('Your clipboard items will appear here.'),
            ),
          ),
        ],
      ),
    );
  }
}
