import 'package:flutter/cupertino.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Favorites'),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text('Starred items only.'),
            ),
          ),
        ],
      ),
    );
  }
}
