import 'package:flutter/cupertino.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Collections'),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text('Work, Personal, Recipes, etc.'),
            ),
          ),
        ],
      ),
    );
  }
}
